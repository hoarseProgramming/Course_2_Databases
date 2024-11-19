// SQL Injection
// Never concatenate user data with executable code, in this case sql code

using Microsoft.Data.SqlClient;

var connectionString = "Server=localhost;Database=everyloop;Trusted_Connection=True;TrustServerCertificate=true";

/*
 *  ' and 1 = 0 union select top 10 username, email, password from users; --
 */

using (var connection = new SqlConnection(connectionString))
{
    connection.Open();

    var searchString = string.Empty;

    while (true)
    {
        Console.Write("Enter new search string: ");

        searchString = Console.ReadLine();

        if (searchString == "") break;

        Console.Clear();

        Console.ForegroundColor = ConsoleColor.DarkGray;
        Console.Write("Search string: ");
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine(searchString);
        Console.ResetColor();

        SearchAirports(connection, searchString);

    }
}

void SearchAirports(SqlConnection connection, string searchString)
{
    // BAD! Opens up for Injection
    //var query = $"""
    //select top 10 
    //    [IATA], 
    //    [Airport name], 
    //    [Location served] 
    //from 
    //    [Airports] 
    //where 
    //    [Location served] like '%{searchString}%';
    //""";

    //Solves the problem!
    var query = """
    select top 10 
        [IATA], 
        [Airport name], 
        [Location served] 
    from 
        [Airports] 
    where 
        [Location served] like CONCAT('%', @searchText, '%');
    """;

    using (var command = new SqlCommand(query, connection))
    {
        //Adds SQL parameter
        command.Parameters.AddWithValue("@searchText", searchString);

        try
        {
            using (SqlDataReader reader = command.ExecuteReader())
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine();
                Console.Write($"{reader.GetName(0).ToUpper(),-10}");
                Console.Write($"{reader.GetName(1).ToUpper(),-50}");
                Console.Write($"{reader.GetName(2).ToUpper()}");
                Console.WriteLine();
                Console.WriteLine();
                Console.ResetColor();

                Console.ForegroundColor = ConsoleColor.Gray;

                while (reader.Read())
                {
                    Console.WriteLine($"{reader.GetValue(0),-10}{reader.GetValue(1),-50}{reader.GetValue(2)}");
                }

                Console.ResetColor();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine();
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine(ex.Message);
            Console.ResetColor();
        }
    }


    Console.WriteLine();
    Console.ForegroundColor = ConsoleColor.Blue;
    Console.WriteLine(query);
    Console.ResetColor();
    Console.WriteLine();

}