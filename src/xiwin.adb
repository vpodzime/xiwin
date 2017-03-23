with Ada.Text_IO;
with Ada.Strings.Unbounded;

with CLI;
with Registry;
with Actions;

procedure Xiwin is
   use Actions;
   use Ada.Strings.Unbounded;
   procedure Print (Str : String) renames Ada.Text_IO.Put_Line;

begin
   declare
      Input : User_Input := CLI.Get_User_Input;
      Choices : Actions_List := Registry.Get_Actions (Input);
   begin
      if Choices'Length /= 0 then
         for A of Choices loop
            Print ("Could run: " & To_String (A.Desc) & "with '" & String (Input) & "'");
         end loop;
      else
         Print ("Nothing to run");
      end if;
   end;
end Xiwin;
