with Registry;          use Registry;
with GNAT.OS_Lib;       use GNAT.OS_Lib;
with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Strings.Unbounded;


package body Actions is

   procedure Show_Bug (Input: User_Input) is
      package Ustr renames Ada.Strings.Unbounded;
      use type Ustr.Unbounded_String;

      FF_Command  : constant String := "firefox";
      Args        : Argument_List_Access;
      Exit_Status : Integer;
      Path        : String_Access;
      Cmd         : UStr.Unbounded_String;
      In_Args     : UStr.Unbounded_String;
      All_Args    : UStr.Unbounded_String;

   begin
      In_Args := "https://bugzilla.redhat.com/show_bug.cgi?id=" & Ustr.Unbounded_String(Input);
      All_Args := FF_Command & " " & In_Args;
      Args := Argument_String_To_List (Ustr.To_String(All_Args));
      Path := Locate_Exec_On_Path (FF_Command);
      Spawn (Program_Name => Path.all,
             Args => Args (Args'First + 1..Args'Last),
             Output_File_Descriptor => Standout,
             Return_Code => Exit_Status);

      Free (Args);
      Free (Path);
   end Show_Bug;

end Actions;
