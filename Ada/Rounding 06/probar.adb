--  gnatprove -P estebanvr.gpr --checks-as-errors --level=0
--  --no-axiom-guard --warnings=error estebanvr.adb
--  Phase 1 of 2: generation of Global contracts ...
--  Phase 2 of 2: flow analysis and proof ...
--  Summary logged in /home/estebanvr/Desktop/Spark/CA 003/
--  obj/gnatprove/gnatprove.out
--  gnatmake -gnata -gnateE -f -q estebanvr.adb

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure estebanvr
  with SPARK_Mode => ON
is

   procedure Make_Positive (Value : in out Integer) with
      Post => Value > 0;
   procedure Make_Positive (Value : in out Integer) is
   begin
      if Value <= 0 then
         Value := 1;
      else
         Value := Value;
      end if;
   end Make_Positive;

   procedure Make_50 (Value : in out Integer) with
      Pre => Value > 0,
      Post => Value < 51 and Value >= 1;
   procedure Make_50 (Value : in out Integer) is
   begin
      if Value >= 50 then
         Value := 50;
      else
         Value := Value;
      end if;
   end Make_50;

   procedure Sums (Amount : in Integer; Results : in out Unbounded_String) with
      Pre => (Amount >= 1 and Amount <= 50)
               and then Length (Results) < Integer'Last - 50 * Amount;
   procedure Sums (Amount : in Integer; Results : in out Unbounded_String) is
      ConstA, ConstB, Sum : Integer;
   begin
      Get (ConstA);
      Make_Positive (ConstA);
      pragma Assert (ConstA > 0);
      Get (ConstB);
      Make_Positive (ConstB);
      pragma Assert (ConstB > 0);
      pragma Assume (ConstA < Integer'Last - ConstB);
      Sum := ConstA + ConstB;
      if Amount = 1 then
         Append (Results, Integer'Image (Sum));
         pragma Assert (Length (Results) < Integer'Last - 20 * (Amount - 1));
      else
         Append (Results, Integer'Image (Sum));
         Sums (Amount - 1, Results);
      end if;
   end Sums;

   procedure Main;
   procedure Main is
      Amnt : Integer;
      Results : Unbounded_String := To_Unbounded_String ("");
   begin
      Get (Amnt);
      Skip_Line;
      Make_Positive (Amnt);
      Make_50 (Amnt);
      Sums (Amnt, Results);
      Trim (Results, Left);
      Put_Line (To_String (Results));
   end Main;

begin
   Main;
end estebanvr;

--  $ cat DATA.lst | ./estebanvr
--  1449584 1547607 888712 1001259 482959 833512 1260954
--  719834 753350 932734 1588077 1119271

