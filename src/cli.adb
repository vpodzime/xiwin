with Ada.Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

with Actions; use Actions;

package body CLI is
   package T_IO renames Ada.Text_IO;

   function Get_User_Input return User_Input is
      Input : User_Input (1..User_Input_Max_Len);
      N_Read : Natural;
   begin
      T_IO.Put ("> ");
      T_IO.Get_Line (String (Input), N_Read);
      return Input (1..N_Read);
   end Get_User_Input;

end CLI;
