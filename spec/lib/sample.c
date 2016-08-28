#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <wchar.h>

struct Score {
  unsigned int play_time;
  long value;
};

struct Person {
  int no;
  wchar_t name[20];
};

struct Members {
  struct Person persons[3];
  struct Members *nextPtr;
};

/**
 * No argument, not return.
 */
void run() {
  int i;
  for (i = 0; i < 10; i++) {
    // Do something...
    ;
  }
}

int add(int a, int b) {
  return a + b;
}

double division(double a, double b) {
  return a / b;
}

void get_no(int *no) {
  *no = 99;
}

char *get_version() {
  return "version 1.0.0";
}

wchar_t *get_wide_str() {
  return L"wide string";
}

void print(const char *msg) {
  puts(msg);
}

void get_score(struct Score *score) {
  score->play_time = 10000;
  score->value = 987654321;
}

void initMember(struct Members **ppMembers) {
  *ppMembers = (struct Members *)malloc(sizeof(struct Members));
  (*ppMembers)->persons[0].no = 1;
  memset((*ppMembers)->persons[0].name, 0, sizeof(wchar_t) * 20);
  wcscpy((*ppMembers)->persons[0].name, L"hogehoge1");
  (*ppMembers)->persons[1].no = 2;
  memset((*ppMembers)->persons[1].name, 0, sizeof(wchar_t) * 20);
  wcscpy((*ppMembers)->persons[1].name, L"hogehoge2");
  (*ppMembers)->persons[2].no = 3;
  memset((*ppMembers)->persons[2].name, 0, sizeof(wchar_t) * 20);
  wcscpy((*ppMembers)->persons[2].name, L"hogehoge3");

  // Next pointer
  struct Members *next = (struct Members *)malloc(sizeof(struct Members));
  next->persons[0].no = 11;
  memset(next->persons[0].name, 0, sizeof(wchar_t) * 20);
  wcscpy(next->persons[0].name, L"fugafuga1");
  next->persons[1].no = 12;
  memset(next->persons[1].name, 0, sizeof(wchar_t) * 20);
  wcscpy(next->persons[1].name, L"fugafuga2");
  next->persons[2].no = 13;
  memset(next->persons[2].name, 0, sizeof(wchar_t) * 20);
  wcscpy(next->persons[2].name, L"fugafuga3");
  (*ppMembers)->nextPtr = next;
}

void freeMember(struct Members **ppMembers) {
  free((*ppMembers)->nextPtr);
  free(*ppMembers);
}
