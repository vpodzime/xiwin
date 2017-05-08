with GNAT.OS_Lib;
with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Actions; use Actions;

package body BuiltinActions is
   function TUS (Str : String) return Unbounded_String renames To_Unbounded_String;

   procedure Show_Bug (Input: User_Input) is
      package OS renames GNAT.OS_Lib;

      FF_Command  : constant String := "firefox";
      Args        : OS.Argument_List_Access;
      Exit_Status : Integer;
      Path        : OS.String_Access;
      Cmd         : Unbounded_String;
      In_Args     : Unbounded_String;
      All_Args    : Unbounded_String;

   begin
      --  TODO: extract the bug number here from the command or pattern
      In_Args := "https://bugzilla.redhat.com/show_bug.cgi?id=" & To_Unbounded_String (String (Input));
      All_Args := FF_Command & " " & In_Args;
      Args := OS.Argument_String_To_List (To_String(All_Args));
      Path := OS.Locate_Exec_On_Path (FF_Command);
      OS.Spawn (Program_Name => Path.all,
                Args => Args (Args'First + 1..Args'Last),
                Output_File_Descriptor => OS.Standout,
                Return_Code => Exit_Status);

      OS.Free (Args);
      OS.Free (Path);
   end Show_Bug;

   Show_Bug_Action : aliased Action (Specific) := (Specific,
                                                   A_Task => Show_Bug'Access,
                                                   Desc => Action_Desc (TUS ("Show rhbz bug report")),
                                                   Cmd => Action_Cmd (TUS ("show-bug"))
                                                  );

   Show_Bug_Pattern_Action : aliased Action (Pattern) := (Pattern,
                                                          A_Task => Show_Bug'Access,
                                                          Desc => Action_Desc (TUS ("Show rhbz bug report")),
                                                          Pattern => Action_Pattern (TUS ("rhbz#[0-9]+"))
                                                         );


   -- definitions of public functions
   function Get_All_Actions return Actions_List is
      All_Actions : Actions_List (1..2) := (1 => Show_Bug_Action'Access,
                                            2 => Show_Bug_Pattern_Action'Access);
   begin
      return All_Actions;
   end Get_All_Actions;

end BuiltinActions;
