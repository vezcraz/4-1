#include<stdio.h>

#define IsStudent(s) (ReadCategory(s)==Student?true:false)
#define IsFaculty(s) (ReadCategory(s)==Faculty?true:false)
#define IsScholar(s) (ReadCategory(s)==Student?true:ReadCategory(s)==Faculty?true:false)

typedef struct person person;

typedef struct student student;

typedef struct faculty faculty;

typedef enum { Student, Faculty, Other } category;
typedef enum { true, false } boolean;

category ReadCategory(person *p) {
  char *s = ((char *)p)+30;
  printf("%p %p %c %c\n",p,s,((char*)p)[30],s[0]);
  switch(s[0]) {
    case 'S': return Student;
    case 'F': return Faculty;
    default: return Other;
  }
}

char *ReadName(person *p) {
  return ((char*)p);
}

void printperson(person *p) {
  if(IsStudent(p)) printf("Student ");
  else if(IsFaculty(p)) printf("Faculty ");
  else printf("Other ");
  printf("%s\n",ReadName(p));
}

int main(void) {
  person *p;
  char s[]="01234567890123456789012345678FF000S";
  printf("%c\n",s[30]);
  p=(person*)s;
  printperson(p);
  return 0;
}
