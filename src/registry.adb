with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Actions;               use Actions;
with BuiltinActions;

package body Registry is
   function TUS (Str : String) return Unbounded_String renames To_Unbounded_String;
   Show_Bug : aliased Action (Specific) := (Specific,
                                            A_Task => BuiltinActions.Show_Bug'Access,
                                            Desc => Action_Desc (TUS ("Show rhbz bug report")),
                                            Cmd => Action_Cmd (TUS ("show-bug"))
                                           );
   All_Actions : Actions_List (1..1) := (1 => Show_Bug'Access);

   function Get_Actions (Input: User_Input) return Actions_List is
      Matching : Actions_List (All_Actions'Range);
      Idx : Natural;
      N_Matched : Natural := 0;
   begin
      Idx := Ada.Strings.Fixed.Index (String (Input), " ");
      if (Idx /= 0) then
         for A of All_Actions loop
            if A.Kind = Specific and then String (Input (Input'First..Idx-1)) = To_String (A.Cmd) then
               N_Matched := N_Matched + 1;
               Matching (N_Matched) := A;
            end if;
         end loop;
      end if;
      return Matching (1..N_Matched);
   end Get_Actions;

end Registry;
