with Ada.Strings.Fixed;
with Actions;               use Actions;
with BuiltinActions;
with GNAT.String_Split;
with Ada.Strings.Unbounded;

package body Registry is
   -- private functions and data

   function Get_Short_Cmd (Act: Action) return Action_Cmd
     with Pre => Act.Kind = Specific;

   Builtin_Actions : Actions_List := BuiltinActions.Get_All_Actions;
   All_Actions : Actions_List (Builtin_Actions'Range) := (Builtin_Actions);

   function Get_Short_Cmd (Act: Action) return Action_Cmd is
      use GNAT.String_Split;
      use Ada.Strings.Unbounded;
      Subs : Slice_Set;
      Seps : constant String := "-";
      Ret : Unbounded_String := To_Unbounded_String ("");
   begin
      Create (Subs, To_String (Act.Cmd), Seps, Mode => Multiple);
      for I in 1..Slice_Count (Subs) loop
         declare
            Sub : constant String := Slice (Subs, I);
         begin
            Ret := Ret & Sub (Sub'First);
         end;
      end loop;
      return Action_Cmd (Ret);
   end;


   -- public functions follow

   function Get_Actions (Input: User_Input) return Actions_List is
      Matching : Actions_List (All_Actions'Range);
      Idx : Natural;
      N_Matched : Natural := 0;
   begin
      Idx := Ada.Strings.Fixed.Index (String (Input), " ");
      Idx := (if Idx /= 0 then Idx else Input'Last + 1);
      for A of All_Actions loop
         if A.Kind = Specific and then (String (Input (Input'First..Idx-1)) = A.Cmd or
                                        String (Input (Input'First..Idx-1)) = Get_Short_Cmd (A.all)) then
            N_Matched := N_Matched + 1;
            Matching (N_Matched) := A;
         end if;
      end loop;
      return Matching (1..N_Matched);
   end Get_Actions;

end Registry;
