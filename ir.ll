; Static type declarations
@type_bool  = global i64 0
@type_int   = global i64 1
@type_vec   = global i64 2

; Dynamic type declarations
%type_v1    = type { i64*, i64, i64*, i64* }
@type_v1    = global %type_v1
  { i64* @type_vec, i64 2, i64* @type_bool, i64* @type_int }

; C function to print vector
declare external void @print_vector (i64*, i64*)

define i64 @main () {
entry:
  ; Allocate vector and load ref
  %vp = alloca  { i64*, i1, i64 }
  %v0 = load    { i64*, i1, i64 }, { i64*, i1, i64 }* %vp

  ; Load tag
  %tv.to.ip = bitcast %type_v1* @type_v1 to i64*

  ; Store elements in vector (tag, 1, 2)
  %v1 = insertvalue { i64*, i1, i64 } %v0, i64* %tv.to.ip, 0
  %v2 = insertvalue { i64*, i1, i64 } %v1, i1 1, 1
  %v3 = insertvalue { i64*, i1, i64 } %v2, i64 2, 2

  ; Update ptr
  store { i64*, i1, i64 } %v3, { i64*, i1, i64 }* %vp

  ; Get i64 ptr to vector
  %vp.to.cp = bitcast { i64*, i1, i64 }* %vp to i64*

  ; Print it
  call void @print_vector (i64* %tv.to.ip, i64* %vp.to.cp)

  ret i64 0
}
