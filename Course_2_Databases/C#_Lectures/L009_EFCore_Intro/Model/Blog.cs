//File scoped namespace
namespace L009_EFCore_Intro.Model;

public class Blog
{
    //Ef will make property called "Id" or (in this case) "BlogId" primary key identity by convention
    public int Id { get; set; }
    //'?' Will allow nulls in database
    public string? Url { get; set; }
    public int? RatingRenamed { get; set; }
    public string Author { get; set; }
    public bool IsOnline { get; set; }
    public DateTime CreatedAt { get; set; }
    public List<Post> Posts { get; set; }
}
