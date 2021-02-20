class Utils
{
  String getDisplayName(String email)
  {
    return "live:${email.split('@')[0]}";
  }

  String getInitials(String displayname)
  {
    List<String> names = displayname.split(" ");
    String first = names[0][0];
    String second = names[1][0];
    return first+second;
  }
}