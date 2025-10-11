#include "stdio.h"


// "std_types.h"

typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned long int uint32_t;
typedef signed char sint8_t;
typedef signed short int sint16_t;
typedef signed long int sint32_t;
typedef float float32_t;
typedef double float64_t;

#include "stdlib.h"

// "patient_linked_list.c"

typedef struct Node{
	uint16_t age;
	uint16_t id;
	uint16_t gender;
	uint16_t reservation;
	char name[50];
	struct Node* next;
} node;

static sint16_t no_of_nodes=0;

node* search_nde(node* head,uint16_t key)
{
	node* temp = head;
	sint16_t i=0;
	if(no_of_nodes==1){
	if(temp ->id != key) temp = NULL;
	}else if(no_of_nodes>1){
	while(temp->id!=key&&i<(no_of_nodes-1)){
		temp = temp ->next;
		i++;
	}
	if(temp ->id != key) temp = NULL;
	}else temp = NULL;
	return temp;
}

node* create_nde(uint16_t age,uint16_t id,uint16_t gender,char *name)
{
	node* temp;
	temp = (node*)malloc(sizeof(node));
	if(temp != NULL )
	{
		for(int i=0;;i++)
		{
			if(name[i]=='\n'){(*temp).name[i]='\0';break;}
			(*temp).name[i] = name[i];
		}
		temp -> age = age;
		temp -> id = id;
		temp -> gender = gender;
		temp -> reservation = 0;
		temp -> next = NULL;
	}else{
		
	}
	return temp;
}

void append_nde(node* nde,node**h_ptr)
{
	no_of_nodes++;
	node * temp = *h_ptr;
	if(*h_ptr == NULL)
	{
		*h_ptr = nde;
	}else {
		while(temp->next !=NULL)
		{
			temp = temp ->next;
		}
		temp ->next = nde;
	}
}

void delete_nde(node** head,uint16_t key)
{
	node* temp = *head;
	node* deleted = search_nde(*head,key);
	if(deleted !=NULL){
	node* ref = deleted ->next;
	if(deleted == *head)
	{
		*head = ref;
		free(deleted);
	}
	else{
		while(temp->next!=deleted)
		{
			temp = temp ->next;
		}
		if(ref != NULL)temp -> next = ref;
		else temp ->next = NULL;
		free(deleted);
	}
	}else{
		printf("data not found");
	}
}

// "reservation.c"

typedef struct {
	char start_time[10];
	char finish_time[10];
	sint16_t id;
	uint16_t reservation_number;
} reservation;

int array_search_rn(reservation *r,uint16_t reservation_number)
{
	int i;
	for(i=0;;i++)
	{
		if(r[i].reservation_number==reservation_number)break;
	}
	return i;
}

int array_search_id(reservation *r,uint16_t id)
{
	int i;
	for(i=0;;i++)
	{
		if(r[i].id==id)break;
	}
	return i;
}


// "admin.c"

void add_patient(node** head,node* created,char *name)
{
	uint16_t age,id,gender;
	printf("please enter ID: ");
	scanf("%hu",&id);
	node* temp =search_nde(*head,id);
	if(temp==NULL){
	printf("please enter age: ");
	scanf("%hu",&age);
	do{
	printf("please enter gender(1 for male or 0 for female): ");
	scanf("%hu",&gender);
	if(gender !=0&&gender!=1) printf("number out of range choose a valid number\n");
	}while(gender!=1&&gender !=0);
	while (getchar() != '\n');
	printf("please enter name: ");
	fgets(name, sizeof(name), stdin);
	created = create_nde(age,id,gender,name);
	//printf("%x\n",created);
	//printf("%x",*head);
	append_nde(created,head);
	}else printf("used ID!");
}

void edit_patient(node *head,char *name)
{
	uint16_t age,id,gender,choice=6;
	printf("please enter ID: ");
	scanf("%hu",&id);
	node * temp = search_nde(head,id);
	if(temp!=NULL){
		while(choice!=5){
			printf("\nto edit:\nid press (1)\nage press (2)\ngender press (3)\nname press (4)\nto finish editing press (5)");
			scanf("%hu",&choice);
			if(choice==1){
				printf("please enter new ID: ");
				scanf("%hu",&id);
				temp ->id = id;
			}else if(choice ==2){
				printf("please enter age: ");
				scanf("%hu",&age);
				temp ->age = age;
			}else if(choice==3){
				do{
				printf("please enter gender(1 for male or 0 for female): ");
				scanf("%hu",&gender);
				if(gender ==0||gender==1)temp ->gender = gender;
				else printf("number out of range choose a valid number\n");
				}while(gender!=1&&gender !=0);
			}else if(choice==4){
				while (getchar() != '\n');
				printf("please enter name: ");
				fgets(name, sizeof(name), stdin);
				for(int i=0;;i++)
				{
					if(name[i]=='\n'){(*temp).name[i]='\0';break;}
					(*temp).name[i] = name[i];
				}
			}else if(choice !=5)printf("number out of range choose a valid number\n");
		}
	}else printf("ID not found!");	
}

void reserve(reservation *r,node *head){
	uint16_t id,num;
	printf("\nAvailable slots :");
	for(int i=0;i<5;i++)
	{
		if(r[i].id==-1)printf("from %s pm to %s pm, reservation number (%hu)\n",r[i].start_time,r[i].finish_time,r[i].reservation_number);
	}
	printf("please enter ID :");
	scanf("%hu",&id);
	node * temp = search_nde(head,id);
	if(temp!=NULL){
		printf("please enter reservation number :");
	    scanf("%hu",&num);
		if(r[array_search_rn(r,num)].id==-1){
			temp ->reservation = num;
			r[array_search_rn(r,num)].id= temp ->id;
			printf("slot reserved succefully :)\n");
		}else("reservation number out of range!\n");
	}else printf("ID not found!");	
}

void cancel_reservation(reservation *r,node *head)
{
	uint16_t id,num;
	printf("please enter ID :");
	scanf("%hu",&id);
	node * temp = search_nde(head,id);
	if(temp!=NULL){
		if(temp->reservation != 0){
			r[array_search_id(r,temp->id)].id= -1;
			temp ->reservation = 0;
			printf("slot reserved succefully :)\n");
		}else("there is no reservations for this id\n");
	}else printf("ID not found!");	
}


// "user.c"

void view_patient(node * head)
{
	uint16_t id;
	printf("please enter ID: ");
	scanf("%hu",&id);
	node * temp = search_nde(head,id);
	if(temp!=NULL){
		printf("patient:-\nID : %hu\nAge :%hu\ngender : %s\nname : %s\n",temp->id,temp->age,temp->gender==1?"male\0":"female\0",temp->name);
	}else printf("ID not found!");
}

void view_reservations(reservation *r)
{
	uint16_t i;
	for(i=0;i<5;i++)
	{
		if(r[i].id!=-1)printf("from %s to %s there as a reservation to patient with ID : %hu\n",r[i].start_time,r[i].finish_time,r[i].id);
	}
}


// "main.c"

void main()
{
	reservation r_1={"2","2:30",-1,1}, r_2={"2:30","3",-1,2}, r_3={"3","3:30",-1,3}, r_4={"4","4:30",-1,4}, r_5={"4:30","a5",-1,5};
	reservation reservations[5]={r_1,r_2,r_3,r_4,r_5};
	uint16_t mode,pass=0,wrong_pass=0,auth=3;
	char name[50];
	node* head=NULL;
	node* created=NULL;
	while(auth!=2){
	printf("\nfor Admin mode press (0)\nfor user mode press (1)\nto exit press (2)\n");
	scanf("%hu",&auth);
	if(auth==0)
	{
		//login process
		while(wrong_pass<3){
		printf("please enter password :");
		scanf("%hu",&pass);
		if(pass==1234)break;
		else if(wrong_pass <3) {printf("wrong pass,please try again!\n");wrong_pass++;}
		}
		if(wrong_pass==3)break;
		mode = 6;
		while(mode !=5){
			printf("\nto add a new patient press(1)\nto edit a patient info press (2)\nto reserve a slot with the doctor press (3)\nto cancel a reservation press (4)\nto exit press (5)\n");
			scanf("%hu",&mode);
			if(mode==1)add_patient(&head,created,&name[0]);
			else if(mode ==2)edit_patient(head,&name[0]);
			else if(mode==3)reserve(&reservations[0],head);
			else if(mode==4)cancel_reservation(&reservations[0],head);
			else if(mode !=5)printf("number out of range choose a valid number\n");
		}
	}else if(auth==1)
	{
		mode = 4;
		while(mode !=3){
			printf("\nto view patient record press(1)\nto view today\'s reservations press (2)\nto exit press (3)\n");
			scanf("%hu",&mode);
			if(mode==1)view_patient(head);
			else if(mode ==2)view_reservations(&reservations[0]);
			else if(mode !=3)printf("number out of range choose a valid number\n");
		}
	}else if(auth!=2) printf("wrong choice,please try again !");
	}
}
