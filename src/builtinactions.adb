with GNAT.OS_Lib;
with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Strings.Unbounded;
with Actions; use Actions;

package body BuiltinActions is

   procedure Show_Bug (Input: User_Input) is
      package OS renames GNAT.OS_Lib;
      package Ustr renames Ada.Strings.Unbounded;
      use type Ustr.Unbounded_String;

      FF_Command  : constant String := "firefox";
      Args        : OS.Argument_List_Access;
      Exit_Status : Integer;
      Path        : OS.String_Access;
      Cmd         : UStr.Unbounded_String;
      In_Args     : UStr.Unbounded_String;
      All_Args    : UStr.Unbounded_String;

   begin
      In_Args := "https://bugzilla.redhat.com/show_bug.cgi?id=" & Ustr.To_Unbounded_String (String (Input));
      All_Args := FF_Command & " " & In_Args;
      Args := OS.Argument_String_To_List (Ustr.To_String(All_Args));
      Path := OS.Locate_Exec_On_Path (FF_Command);
      OS.Spawn (Program_Name => Path.all,
                Args => Args (Args'First + 1..Args'Last),
                Output_File_Descriptor => OS.Standout,
                Return_Code => Exit_Status);

      OS.Free (Args);
      OS.Free (Path);
   end Show_Bug;

end BuiltinActions;
