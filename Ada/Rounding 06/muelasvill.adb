--  gnatprove -P muelasvill.gpr --checks-as-errors --level=0 --no-axiom-guard
--  --warnings=error --counterexamples=on -u muelasvill.adb
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: analysis of data and information flow ...
--  Summary logged in /home/lsaavedra/proved/gnatprove/gnatprove.out
--  gnatprove: unproved check messages considered as errors

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure muelasvill with
  SPARK_Mode => OFF
is
   type ArrayIntegers is array (Integer range <>) of Integer;
   procedure readVector (A, B : in out ArrayIntegers; i : in Integer);
   procedure showVector (A, B : in ArrayIntegers; i : in Integer);
   procedure resultSum (A, B : in ArrayIntegers; i : in Integer);
   function getVectorSize return Integer;

   function getVectorSize return Integer is
      Size : Integer;
   begin
      Get (Size);
      return Size;
   end getVectorSize;
   procedure readVector (A, B : in out ArrayIntegers; i : in Integer) is
   begin
      if i = A'Length or i = B'Length then
         return;
      end if;
      if i >= A'First and i <= A'Last and i >= B'First and i <= B'Last then
         Get (A (i));
         Get (B (i));
         readVector (A, B, i + 1);
      end if;
   end readVector;
   procedure showVector (A, B : in ArrayIntegers; i : in Integer) is
   begin
      if i = A'Length or i = B'Length then
         return;
      end if;
      if i >= A'First and i <= A'Last and i >= B'First and i <= B'Last then
         Put (A (i));
         Put (B (i));
         showVector (A, B, i + 1);
      end if;
   end showVector;
   procedure resultSum (A, B : in ArrayIntegers; i : in Integer) is

      dividend : Integer;
      divider  : Integer;
      maxMod   : Integer;
      halfMod  : Integer;
      quotient : Integer;
      residue  : Integer;
      answer   : Integer;
      band     : Integer;

   begin

      if i = A'Length or i = B'Length then
         return;
      end if;

      if i >= A'First and i <= A'Last and i >= B'First and i <= B'Last then

         dividend := A (i);
         divider  := B (i);

         if dividend < 0 and divider < 0 then
            band := 1;
         elsif dividend > 0 and divider > 0 then
            band := 1;
         else
            band := 0;
         end if;

         if dividend < 0 then
            dividend := dividend * (-1);
         end if;

         if divider < 0 then
            divider := divider * (-1);
         end if;

         maxMod  := divider - 1;
         halfMod := maxMod / 2;

         quotient := (dividend / divider);
         residue  := dividend - (quotient * divider);

         if residue > halfMod and quotient > 0 then
            answer := quotient + 1;
         else
            answer := quotient;
         end if;

         if (band = 0) then
            Put (" ");
            Put (Integer'Image (answer * (-1)));
         else
            Put (Integer'Image (answer));
         end if;

         resultSum (A, B, i + 1);

      end if;
   end resultSum;
begin
   declare
      vectorSize       : Integer := getVectorSize;
      vectorA, vectorB : ArrayIntegers (0 .. vectorSize);
   begin
      readVector (vectorA, vectorB, 1);
      resultSum (vectorA, vectorB, 1);
   end;
end muelasvill;

--  $ cat DATA.lst | ./muelasvill
--   4 -6 24485 4 1199 2 5 13 14 13 4 10 25384
-- 318144 2051 11 6 10 3 4 38 4 17 -4 7 10
