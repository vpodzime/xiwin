with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.IO_Exceptions;

with CLI;
with Registry;
with Actions;

procedure Xiwin is
   use Actions;
   use Ada.Strings.Unbounded;
   procedure Print (Str : String) renames Ada.Text_IO.Put_Line;

begin
   loop
      declare
         Input : User_Input := CLI.Get_User_Input;
         Choices : Actions_List := Registry.Get_Actions (Input);
      begin
         if Choices'Length /= 0 then
            for A of Choices loop
               Print ("Could run: " & To_String (A.Desc) & " with '" & String (Input) & "'");
            end loop;
         else
            Print ("Nothing to run");
         end if;
      end;
   end loop;
exception
   --  EOF is a correct way to terminate the program
   when Ada.IO_Exceptions.END_ERROR =>
      null;
end Xiwin;
