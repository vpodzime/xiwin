with Ada.Text_IO;
with Ada.Strings.Unbounded;

with CLI;
with Registry;
with Actions;

procedure Xiwin is
   use Actions;
   use Ada.Strings.Unbounded;
   procedure Print (Str : String) renames Ada.Text_IO.Put_Line;

   Input : User_Input;

begin
   Input := CLI.Get_User_Input;
   declare
      Choices : Actions_List := Registry.Get_Actions (Input);
   begin
      for A of Choices loop
         Print ("Would run: " & To_String (A.Desc));
      end loop;
   end;
end Xiwin;
