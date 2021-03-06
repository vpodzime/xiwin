with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

package Actions is
   User_Input_Max_Len : constant := 100;
   type User_Input is new String
     with Dynamic_Predicate => User_Input'Length <= 100 and User_Input'First = 1;
   type Action_Desc is new Unbounded_String;  --  String(1..100);
   type Action_Cmd is new Unbounded_String;
   type Action_Pattern is new Unbounded_String;
   type Action_Kind is (Specific, Pattern);
   type Action_Task is not null access procedure (Input : User_Input);

   type Action (Kind: Action_Kind) is
      record
         Desc: Action_Desc;
         A_Task : Action_Task;
         case Kind is
            when Specific =>
               Cmd: Action_Cmd;
            when Pattern =>
               Pattern: Action_Pattern;
         end case;
      end record;

   type Action_Access is access all Action;
   type Actions_List is array (Natural range <>) of Action_Access;

end Actions;
