with Ada.Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

with Actions; use Actions;

package body CLI is
   package T_IO renames Ada.Text_IO;

   function Get_User_Input return User_Input is
      Input : User_Input;
      N_Read : Natural;
   begin
      T_IO.Put ("> ");
      T_IO.Get_Line (Input, N_Read);
      return Input;
   end Get_User_Input;

end CLI;
