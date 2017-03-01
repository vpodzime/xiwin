with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Registry.Actions; use Registry.Actions;
with Registry.BuiltinActions;

package body Registry is
   function TUS (Str : String) return Unbounded_String renames To_Unbounded_String;
   Show_Bug : aliased Action (Specific) := (Specific,
                                            A_Task => BuiltinActions.Show_Bug'Access,
                                            Desc => Action_Desc (TUS("Show rhbz bug report")),
                                            Cmd => Action_Cmd (TUS("show-bug"))
                                           );


   function Get_Actions (Input: User_Input) return Actions_List is
      Matching : Actions_List (1..1);
   begin
      Matching (1) := Show_Bug'Access;
      return Matching;
   end Get_Actions;

end Registry;
