/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 11                       */
/* Created on:     06.01.2017 16:54:45                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_SPIELER_SPIELT_BE_VEREIN') then
    alter table SPIELER
       delete foreign key FK_SPIELER_SPIELT_BE_VEREIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRAINER_TRAINIERT_VEREIN') then
    alter table TRAINER
       delete foreign key FK_TRAINER_TRAINIERT_VEREIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSFER_TRANSFERI_VEREIN') then
    alter table TRANSFER
       delete foreign key FK_TRANSFER_TRANSFERI_VEREIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSFER_WECHSELT_SPIELER') then
    alter table TRANSFER
       delete foreign key FK_TRANSFER_WECHSELT_SPIELER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_VEREIN_TRAINIERT_TRAINER') then
    alter table VEREIN
       delete foreign key FK_VEREIN_TRAINIERT_TRAINER
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='SPIELT_BEI_FK'
     and t.table_name='SPIELER'
) then
   drop index SPIELER.SPIELT_BEI_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='SPIELER_PK'
     and t.table_name='SPIELER'
) then
   drop index SPIELER.SPIELER_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SPIELER'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SPIELER
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TRAINIERT2_FK'
     and t.table_name='TRAINER'
) then
   drop index TRAINER.TRAINIERT2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TRAINER_PK'
     and t.table_name='TRAINER'
) then
   drop index TRAINER.TRAINER_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TRAINER'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TRAINER
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='WECHSELT_FK'
     and t.table_name='TRANSFER'
) then
   drop index TRANSFER.WECHSELT_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TRANSFERIERT_FK'
     and t.table_name='TRANSFER'
) then
   drop index TRANSFER.TRANSFERIERT_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TRANSFER_PK'
     and t.table_name='TRANSFER'
) then
   drop index TRANSFER.TRANSFER_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TRANSFER'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TRANSFER
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TRAINIERT_FK'
     and t.table_name='VEREIN'
) then
   drop index VEREIN.TRAINIERT_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='VEREIN_PK'
     and t.table_name='VEREIN'
) then
   drop index VEREIN.VEREIN_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='VEREIN'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table VEREIN
end if;

/*==============================================================*/
/* Table: SPIELER                                               */
/*==============================================================*/
create table SPIELER 
(
   SPIELER_ID           integer                        not null default autoincrement,
   VERINS_ID            integer                        null,
   NAME                 varchar(100)                   not null,
   GEB_DAT              date                           null,
   POSITION             varchar(7)                     null,
   GEHALT               numeric(8,2)                   null,
   MARKTWERT            numeric(8,2)                   null,
   BEWERTUNG            smallint                       null,
   constraint PK_SPIELER primary key (SPIELER_ID)
);

/*==============================================================*/
/* Index: SPIELER_PK                                            */
/*==============================================================*/
create unique index SPIELER_PK on SPIELER (
SPIELER_ID ASC
);

/*==============================================================*/
/* Index: SPIELT_BEI_FK                                         */
/*==============================================================*/
create index SPIELT_BEI_FK on SPIELER (
VERINS_ID ASC
);

/*==============================================================*/
/* Table: TRAINER                                               */
/*==============================================================*/
create table TRAINER 
(
   TRAINER_ID           integer                        not null default autoincrement,
   VERINS_ID            integer                        null,
   NAME                 varchar(100)                   not null,
   GEB_DAT              date                           null,
   constraint PK_TRAINER primary key (TRAINER_ID)
);

/*==============================================================*/
/* Index: TRAINER_PK                                            */
/*==============================================================*/
create unique index TRAINER_PK on TRAINER (
TRAINER_ID ASC
);

/*==============================================================*/
/* Index: TRAINIERT2_FK                                         */
/*==============================================================*/
create index TRAINIERT2_FK on TRAINER (
VERINS_ID ASC
);

/*==============================================================*/
/* Table: TRANSFER                                              */
/*==============================================================*/
create table TRANSFER 
(
   TRANSFER_ID          integer                        not null default autoincrement,
   SPIELER_ID           integer                        not null,
   VERINS_ID            integer                        not null,
   DATUM                date                           not null,
   constraint PK_TRANSFER primary key (TRANSFER_ID)
);

/*==============================================================*/
/* Index: TRANSFER_PK                                           */
/*==============================================================*/
create unique index TRANSFER_PK on TRANSFER (
TRANSFER_ID ASC
);

/*==============================================================*/
/* Index: TRANSFERIERT_FK                                       */
/*==============================================================*/
create index TRANSFERIERT_FK on TRANSFER (
VERINS_ID ASC
);

/*==============================================================*/
/* Index: WECHSELT_FK                                           */
/*==============================================================*/
create index WECHSELT_FK on TRANSFER (
SPIELER_ID ASC
);

/*==============================================================*/
/* Table: VEREIN                                                */
/*==============================================================*/
create table VEREIN 
(
   VERINS_ID            integer                        not null default autoincrement,
   TRAINER_ID           integer                        not null,
   VEREINSNAME          varchar(50)                    not null,
   STADION              varchar(30)                    not null,
   TEL_NR               varchar(15)                    null,
   constraint PK_VEREIN primary key (VERINS_ID)
);

/*==============================================================*/
/* Index: VEREIN_PK                                             */
/*==============================================================*/
create unique index VEREIN_PK on VEREIN (
VERINS_ID ASC
);

/*==============================================================*/
/* Index: TRAINIERT_FK                                          */
/*==============================================================*/
create index TRAINIERT_FK on VEREIN (
TRAINER_ID ASC
);

alter table SPIELER
   add constraint FK_SPIELER_SPIELT_BE_VEREIN foreign key (VERINS_ID)
      references VEREIN (VERINS_ID)
      on update restrict
      on delete restrict;

alter table TRAINER
   add constraint FK_TRAINER_TRAINIERT_VEREIN foreign key (VERINS_ID)
      references VEREIN (VERINS_ID)
      on update restrict
      on delete restrict;

alter table TRANSFER
   add constraint FK_TRANSFER_TRANSFERI_VEREIN foreign key (VERINS_ID)
      references VEREIN (VERINS_ID)
      on update restrict
      on delete restrict;

alter table TRANSFER
   add constraint FK_TRANSFER_WECHSELT_SPIELER foreign key (SPIELER_ID)
      references SPIELER (SPIELER_ID)
      on update restrict
      on delete restrict;

alter table VEREIN
   add constraint FK_VEREIN_TRAINIERT_TRAINER foreign key (TRAINER_ID)
      references TRAINER (TRAINER_ID)
      on update restrict
      on delete restrict;

