(** Check class definitions are well-formed (using the trait definitions) *)

open Core

val type_class_defns :
     Parsing.Parsed_ast.class_defn list
  -> Parsing.Parsed_ast.function_defn list
  -> Typed_ast.class_defn list Or_error.t
