// Entity Framework introduction

using L009_EFCore_Intro.Model;
using Microsoft.EntityFrameworkCore;

//EnsureDatabaseIsDeleted();

//EnsureDatabaseIsCreated();

CreateBlog("anotherBlog.com");

//Printed argument
var myBlogs = GetBlogs(printSQL: true);


foreach (var blog in myBlogs)
{
    Console.WriteLine($"URL: {blog.Url}, Rating: {blog.RatingRenamed}");
}

static void EnsureDatabaseIsCreated()
{
    // Is disposed when current scope goes out of scope
    using var db = new BloggingContext();

    //Creates database if it doesn't exist.
    db.Database.EnsureCreated();
}

static void EnsureDatabaseIsDeleted()
{
    // Is disposed when current scope goes out of scope
    using var db = new BloggingContext();

    //Deletes database if it exists.
    db.Database.EnsureDeleted();
}

static void CreateBlog(string url, int rating = 5)
{
    var blog = new Blog() { Url = url, RatingRenamed = rating };

    using var db = new BloggingContext();

    db.Blogs.Add(blog);

    //Gotta save the changes!
    db.SaveChanges();
}

static List<Blog> GetBlogs(string searchString = "", bool printSQL = false)
{
    using var db = new BloggingContext();

    //Expression tree
    var query = db.Blogs.Where(b => b.Url.Contains(searchString)).OrderByDescending(b => b.RatingRenamed).ThenBy(b => b.Url);

    if (printSQL)
    {
        Console.WriteLine(query.ToQueryString());
        Console.WriteLine();
    }

    //ToList() will use the expression tree to calculate sql code and connect to Database.
    return query.ToList();
}

static void GetAllPosts()
{
    using var db = new BloggingContext();
    var posts = db.Posts.ToList();
}