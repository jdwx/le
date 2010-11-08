/*
 * Copyright (c) 1993-1997 by Alexander V. Lukyanov (lav@yars.free.net)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <config.h>
#include <ctype.h>
#include "edit.h"

void  ReplaceCharExtMove(byte ch)
{
   if(Char()=='\t' && ch!='\t')
     ExpandTab();
   InsertChar(ch);
   if(!Eol() || Bol())
     DeleteChar();
}
void  ReplaceCharExt(byte ch)
{
   ReplaceCharExtMove(ch);
   MoveLeft();
   stdcol=GetCol();
}
void  ReplaceWCharExtMove(wchar_t ch)
{
   if(Char()=='\t' && ch!='\t')
      ExpandTab();
   InsertWChar(ch);
   if(!Eol() || Bol())
      DeleteChar();
}
void  ReplaceWCharExt(wchar_t ch)
{
   ReplaceWCharExtMove(ch);
   MoveLeftOverEOL();
   stdcol=GetCol();
}

void  ExpandAllTabs()
{
   num ol=GetLine(),oc=GetCol();
   static  struct  menu EATmenu[]={
   {"   &Ok   ",MIDDLE-6,FDOWN-2},
   {" &Cancel ",MIDDLE+6,FDOWN-2},
   {NULL}};

   switch(ReadMenuBox(EATmenu,HORIZ,"ALL tab characters will be\nexpanded to spaces",
      " Verify ",VERIFY_WIN_ATTR,CURR_BUTTON_ATTR))
   {
   case(0):
   case('C'):
      return;
   }
   MessageSync("Expanding...");
   CurrentPos=TextBegin;
   while(!Eof())
   {
      if(Char()=='\t')
         ExpandTab();
      MoveRight();
   }
   MoveLineCol(ol,oc);
   stdcol=GetCol();
}

void  ExpandSpanTabs()
{
   num ol=GetLine(),oc=GetCol();
   static  struct  menu EATmenu[]={
   {"   &Ok   ",MIDDLE-6,FDOWN-2},
   {" &Cancel ",MIDDLE+6,FDOWN-2},
   {NULL}};

   switch(ReadMenuBox(EATmenu,HORIZ,"Spans of tab characters will be\nexpanded to spaces + one tab",
      " Verify ",VERIFY_WIN_ATTR,CURR_BUTTON_ATTR))
   {
   case(0):
   case('C'):
      return;
   }
   MessageSync("Expanding...");
   CurrentPos=TextBegin;
   while(!Eof())
   {
      if(Char()=='\t' && CharRel(1)=='\t')
         ExpandTab();
      MoveRight();
   }
   MoveLineCol(ol,oc);
   stdcol=GetCol();
}

void  DOS_UNIX_switch()
{
   DosEol=!DosEol;
   SetEolStr(DosEol?"\r\n":"\n");
}

void  DOS_UNIX(void)
{
   num ol=GetLine(),oc=GetCol();
   static  struct  menu YesNoCancel[]={
   {"   &Yes   ",MIDDLE-10,FDOWN-2},
   {"   &No   ",MIDDLE,FDOWN-2},
   {" &Cancel ",MIDDLE+10,FDOWN-2},
   {NULL}};

   switch(ReadMenuBox(YesNoCancel,HORIZ,"Do you want to change EOLs?"," UNIX<->DOS ",
      VERIFY_WIN_ATTR,CURR_BUTTON_ATTR))
   {
   case(0):
   case('C'):
      return;
   case('Y'):
      MessageSync("Changing EOLs between DOS and UNIX formats...");
      CurrentPos=TextBegin;
      while(!Eof())
      {
         if(Eol())
         {
	    DOS_UNIX_switch();
            NewLine();
	    DOS_UNIX_switch();
            DeleteEOL();
         }
         else
            MoveRight();
      }
      DOS_UNIX_switch();
      CurrentPos=TextBegin;
      ScrShift=0;
      ScreenTop=CurrentPos;
      MoveLineCol(ol,oc);
      break;
   case('N'):
      DOS_UNIX_switch();
      CurrentPos=TextBegin;
      ScrShift=0;
      ScreenTop=CurrentPos;
   }
   TextPoint::OrFlags(COLUNDEFINED|LINEUNDEFINED);
   stdcol=GetCol();
}

int   Suffix(const char *str,const char*pr)
{
   int	 shift=strlen(str)-strlen(pr);

   return(shift>=0 && !strcmp(str+shift,pr));
}
