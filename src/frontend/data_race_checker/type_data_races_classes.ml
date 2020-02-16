open Core
open Type_data_races_expr
open Type_region_annotations
open Desugaring.Desugared_ast
open Ast.Ast_types

let type_region_capability error_prefix (TRegion (cap, region_name)) =
  match cap with
  | Linear | Read | Locked | Thread | Subordinate -> Ok ()
  | Safe ->
      Error
        (Error.of_string
           (Fmt.str "%s Region %s can't be assigned capability %s." error_prefix
              (Region_name.to_string region_name)
              (string_of_cap cap)))

let type_field_defn class_name regions error_prefix
    (TField (_, field_type, field_name, field_regions)) =
  let open Result in
  ( match field_type with
  | TEClass (_, Borrowed) ->
      Error
        (Error.of_string
           (Fmt.str "%s Field %s can't be assigned a borrowed type." error_prefix
              (Field_name.to_string field_name)))
  | _                     -> Ok () )
  >>= fun () -> type_field_region_annotations class_name regions field_regions

(* check all fields in a region have the same type *)
let type_fields_region_types fields error_prefix (TRegion (_, reg_name)) =
  let region_fields =
    List.filter
      ~f:(fun (TField (_, _, _, field_regions)) ->
        List.exists ~f:(fun field_region -> field_region = reg_name) field_regions)
      fields in
  let field_types =
    List.map ~f:(fun (TField (_, field_type, _, _)) -> field_type) region_fields in
  match field_types with
  | []              ->
      Error
        (Error.of_string
           (Fmt.str "%s: region %s is unused@." error_prefix
              (Region_name.to_string reg_name)))
  | field_type :: _ ->
      if List.for_all ~f:(fun fd_type -> field_type = fd_type) field_types then Ok ()
      else
        Error
          (Error.of_string
             (Fmt.str "%sregion %s should have fields of the same type@." error_prefix
                (Region_name.to_string reg_name)))

let type_data_races_method_defn class_defns
    (TMethod (method_name, ret_type, params, region_effects, body_expr)) =
  let open Result in
  type_params_region_annotations class_defns params
  >>= fun () ->
  type_data_races_block_expr class_defns body_expr
  >>| fun data_race_checked_body_expr ->
  TMethod (method_name, ret_type, params, region_effects, data_race_checked_body_expr)

let type_data_races_class_defn class_defns
    (TClass (class_name, regions, fields, method_defns)) =
  let open Result in
  (* All type error strings for a particular class have same prefix *)
  let error_prefix = Fmt.str "%s has a type error: " (Class_name.to_string class_name) in
  Result.all_unit (List.map ~f:(type_region_capability error_prefix) regions)
  >>= fun () ->
  Result.all_unit (List.map ~f:(type_fields_region_types fields error_prefix) regions)
  >>= fun () ->
  Result.all (List.map ~f:(type_field_defn class_name regions error_prefix) fields)
  >>= fun _ ->
  Result.all (List.map ~f:(type_data_races_method_defn class_defns) method_defns)
  >>| fun data_race_checked_method_defns ->
  TClass (class_name, regions, fields, data_race_checked_method_defns)