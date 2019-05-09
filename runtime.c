#include <stdio.h>
#include <stdint.h>

extern int64_t type_bool;
extern int64_t type_int;
extern int64_t type_vec;

void print_any (int64_t* tag, int64_t* val);

void print_bool (char b) {
  int val = (int) b;
  printf("%s", val ? "true" : "false");
}

void print_int (int64_t i) {
  printf("%lld", i);
}

void print_vector (int64_t* tag, int64_t* vec) {
  int64_t size = tag[1];
  printf ("(");
  for (int64_t i = 0; i < size; ++i) {
    int64_t* ty = (int64_t*)tag[i + 2];
    print_any (ty, (int64_t*)vec[1 + i]);
    if (i != size - 1) {
      printf (", ");
    }
  }
  printf (")");
}

void print_any (int64_t* tag, int64_t* val) {
  if (*tag == type_int) {
    print_int ((int64_t) val);
  }
  if (*tag == type_bool) {
    print_bool ((int64_t) val);
  }
  if (*tag == type_vec) {
    print_vector (tag, val);
  }
}

void print_type (int64_t type) {
  if (type == type_bool) {
    printf ("Bool");
  }
  if (type == type_int) {
    printf ("Int");
  }
}
