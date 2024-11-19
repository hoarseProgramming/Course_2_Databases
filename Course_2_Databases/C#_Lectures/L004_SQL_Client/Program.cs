using Microsoft.Data.SqlClient;

//Found on connectionstrings.com:
//TrustServerCertificate=True; Auto trust on certificate, shouldn't be done in real life situations.

var connectionString = "Server=localhost;Database=everyloop;Trusted_Connection=True;TrustServerCertificate=True;";

//How to copy queries from SQL management studio directyly
var query = """
select 
    * 
from 
    types;
""";

//SqlConnection class = Connecttion to DB
using (var connection = new SqlConnection(connectionString))
using (var command = new SqlCommand(query, connection))
{
    //Opens connection
    connection.Open();

    // Non select query
    // command.ExecuteNonQuery()

    //Sends command text to connection and returns a SQL data reader with all results
    using (var reader = command.ExecuteReader())
    {
        //Loop all columns
        for (int i = 0; i < reader.FieldCount; i++)
        {
            //Gets column name | Net type | Sql type :
            Console.WriteLine($"{reader.GetName(i),-20}{reader.GetFieldType(i),-20}{reader.GetDataTypeName(i)}");
        }

        Console.WriteLine();

        //First instance of read sets row to 0, advances one step every iteration,
        //returns true/false depending on if there is a row to read or not

        while (reader.Read())
        {
            for (int i = 0; i < reader.FieldCount; i++)
            {
                //Returns object
                Console.Write($"{reader.GetValue(i)}, ");

                //Returns string
                //Console.Write($"{reader.GetString(i)}, ");
            }
            Console.WriteLine();
        }
    }
}