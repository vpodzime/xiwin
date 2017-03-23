with Ada.Strings.Fixed;
with Actions;               use Actions;
with BuiltinActions;

package body Registry is
   Builtin_Actions : Actions_List := BuiltinActions.Get_All_Actions;
   All_Actions : Actions_List (Builtin_Actions'Range) := (Builtin_Actions);

   function Get_Actions (Input: User_Input) return Actions_List is
      Matching : Actions_List (All_Actions'Range);
      Idx : Natural;
      N_Matched : Natural := 0;
   begin
      Idx := Ada.Strings.Fixed.Index (String (Input), " ");
      if (Idx /= 0) then
         for A of All_Actions loop
            if A.Kind = Specific and then String (Input (Input'First..Idx-1)) = A.Cmd then
               N_Matched := N_Matched + 1;
               Matching (N_Matched) := A;
            end if;
         end loop;
      end if;
      return Matching (1..N_Matched);
   end Get_Actions;

end Registry;
