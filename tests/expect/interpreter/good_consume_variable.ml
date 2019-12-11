open Core
open Print_execution

let%expect_test "Consume variable" =
  print_execution
    " 
    class Foo = linear Bar {
      const f : int
      const g : int  
      const h : int

    }
    class Choco = thread Late {
      const f : int
    }
    class Bana = read Na {
      const f : int
    }
    thread trait Late {
      require const f : int
    }
    read trait Na {
      require const f : int
    }
    linear trait Bar {
      require const f : int
      require const g : int  
      require const h : int
    }
    begin
      let x = new Foo(f:4, g:5, h:6) in
        let y = consume x in (* Consume linear variable *)
          let z = 5 in
            let w = consume z in (* Can consume an int *)
              y.h
            end
          end
        end
      end ;
      let x = new Choco(f:5) in
        let y = consume x in 
          y
        end
      end;
        let x = new Bana(f:5) in
        let y = consume x in 
          y
        end
      end
    end
  " ;
  [%expect
    {|
    ----- Step 0 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 4); PUSH(Int: 5); PUSH(Int: 6); CONSTRUCTOR(Foo); HEAP_FIELD_SET(h); HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [  ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 1 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); PUSH(Int: 6); CONSTRUCTOR(Foo); HEAP_FIELD_SET(h); HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 4 ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 2 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 6); CONSTRUCTOR(Foo); HEAP_FIELD_SET(h); HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Value: Int: 4 ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 3 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ CONSTRUCTOR(Foo); HEAP_FIELD_SET(h); HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6, Value: Int: 5, Value: Int: 4 ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 4 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(h); HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Value: Int: 6, Value: Int: 5, Value: Int: 4 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: {  } } ]
    ------------------------------------------
    ----- Step 5 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(g); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Value: Int: 5, Value: Int: 4 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6 } } ]
    ------------------------------------------
    ----- Step 6 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Value: Int: 4 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 7 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 8 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 9 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(NULL); STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 10 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_SET(x); BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: NULL, Value: Address: 1, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 11 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(y); PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 12 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 13 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(z); STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 14 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(z); PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ z -> Int: 5 ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 15 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(NULL); STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ z -> Int: 5 ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 16 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_SET(z); BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: NULL, Value: Int: 5, Env: [ z -> Int: 5 ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 17 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(w); STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 18 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(y); HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Int: 5 ], Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 19 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_LOOKUP(h); SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 1, Env: [ w -> Int: 5 ], Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 20 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6, Env: [ w -> Int: 5 ], Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 21 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Int: 5 ], Value: Int: 6, Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 22 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6, Env: [ z -> NULL ], Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 23 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ z -> NULL ], Value: Int: 6, Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 24 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6, Env: [ y -> Address: 1 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 25 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 1 ], Value: Int: 6, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 26 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 27 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> NULL ], Value: Int: 6 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 28 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 6 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 29 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [  ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 30 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } } ]
    ------------------------------------------
    ----- Step 31 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Value: Int: 5 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: {  } } ]
    ------------------------------------------
    ----- Step 32 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 33 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 2 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 34 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 2 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 35 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: NULL, Value: Address: 2, Env: [ x -> Address: 2 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 36 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 37 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(y); SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 38 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ y -> Address: 2 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 39 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Value: Address: 2, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 40 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 41 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> NULL ], Value: Address: 2 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 42 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 43 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [  ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 44 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 45 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Value: Int: 5 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: {  } } ]
    ------------------------------------------
    ----- Step 46 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(x); STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 47 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 3 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 48 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(NULL); STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ x -> Address: 3 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 49 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_SET(x); BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: NULL, Value: Address: 3, Env: [ x -> Address: 3 ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 50 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(y); STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 51 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(y); SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 3 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 52 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ y -> Address: 3 ], Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 53 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 3 ], Value: Address: 3, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 54 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ x -> NULL ] ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 55 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP ]
       └──Stack: [ Env: [ x -> NULL ], Value: Address: 3 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 56 - OUTPUT STATE --------
    Threads:
    └──Thread: 1
       └──Instructions: [  ]
       └──Stack: [ Value: Address: 3 ]
    Heap: [ 1 -> { Class_name: Foo, Fields: { h: Int: 6; g: Int: 5; f: Int: 4 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    Output: Address: 3 |}]