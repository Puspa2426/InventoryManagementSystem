package InventoryManagementSystem;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Driver
{
    public static String Login ( final String username, final String password )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        String output = "Invalid";

        String sql = "SELECT \"Display Name\",\"E-mail\",\"Profile Picture\",\"Account Type\" FROM \"User Profile\" WHERE \"Username\"=? AND \"Password\"=?";

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql ) )
        {
            ps.setString ( 1, username );
            ps.setString ( 2, password );

            try ( final ResultSet rs = ps.executeQuery() )
            {
                if ( rs.next() )
                {
                    final String displayName = rs.getString ( 1 );
                    final String email = rs.getString ( 2 );
                    final long profilePicture = rs.getLong ( 3 );
                    final String accountType = rs.getString ( 4 );

                    output = "Success`" + displayName + "`" + email + "`" + profilePicture + "`" + accountType;
                }
            }
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String RetrieveEmailPassword ( final String username )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return null;
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        final String sql = "SELECT \"E-mail\",\"Password\" FROM \"User Profile\" WHERE \"Username\"=?";

        String output = "";
        
        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );
            ps.setString ( 1, username );

            rs = ps.executeQuery();

            if ( rs.next() )
            {
                final String email = rs.getString ( 1 );
                final String password = rs.getString ( 2 );

                output = "Success" + email + "`" + password;
            }
        }
        catch ( final SQLException e )
        {
            output = e.getMessage();
            e.printStackTrace();
        }
        finally
        {
            try
            {
                if ( rs != null ) rs.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String AddUser ( final String username, final String displayName, final String email, final String password )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        String output = "Success";

        String sql = "SELECT COUNT(*) FROM \"User Profile\" WHERE \"Username\"=?";

        boolean isDuplicate = false;
        
        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );
            ps.setString ( 1, username );

            rs = ps.executeQuery();

            rs.next();

            isDuplicate = ( rs.getLong ( 1 ) > 0 );
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                if ( rs != null ) rs.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}
        }

        if ( isDuplicate )
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
            
            return "Duplicate";
        }

        ps = null;

        sql = "INSERT INTO \"User Profile\" (\"Username\",\"Display Name\",\"E-mail\",\"Password\",\"Profile Picture\",\"Account Type\") VALUES (?,?,?,?,?,?)";

        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );
            ps.setString ( 1, username );
            ps.setString ( 2, displayName );
            ps.setString ( 3, email );
            ps.setString ( 4, password );
            ps.setLong ( 5, 0L );
            ps.setString ( 6, "Retailer" );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String SaveProfile ( final String oldUsername, final String newUsername, final String displayName, final String email, String password,
        final long oldProfilePicture, final long profilePicture )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        String output = "Success";

        String sql = "SELECT \"Password\" FROM \"User Profile\" WHERE \"Username\"=?";

        boolean isExist = false;
        final String oldPassword;

        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );
            ps.setString ( 1, oldUsername );

            rs = ps.executeQuery();

            isExist = rs.next();

            if ( isExist && password.isEmpty() )
                password = rs.getString ( 1 );
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                if ( rs != null ) rs.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}
        }

        if ( !isExist )
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
            
            return "Not Found";
        }

        ps = null;

        sql = "UPDATE \"User Profile\" SET \"Username\"=?,\"Display Name\"=?,\"E-mail\"=?,\"Password\"=?,\"Profile Picture\"=? WHERE \"Username\"=?";

        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );
            ps.setString ( 1, newUsername );
            ps.setString ( 2, displayName );
            ps.setString ( 3, email );
            ps.setString ( 4, password );
            ps.setLong ( 5, profilePicture );
            ps.setString ( 6, oldUsername );

            ps.executeUpdate();

            if ( oldProfilePicture != 0 )
                Data.databaseLocal.UnlinkLargeObject ( oldProfilePicture );

            Data.databaseLocal.Commit();
        }
        catch ( final SQLException eSQL )
        {
            eSQL.printStackTrace();
            output = eSQL.getMessage();
        }
        catch ( final IOException eIO )
        {
            eIO.printStackTrace();
            output = eIO.getMessage();
        }
        finally
        {
            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String[] ReadProductCategories()
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return null;
        }

        final String sql = "SELECT \"Category\" FROM \"Product Categories\" ORDER BY \"Category\" ASC";

        final ArrayList<String> alProductCategories = new ArrayList<>();

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql );
              final ResultSet rs = ps.executeQuery() )
        {
            while ( rs.next() )
            {
                alProductCategories.add ( rs.getString ( 1 ) );
            }
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return null;
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return alProductCategories.toArray ( new String [ alProductCategories.size() ] );
    }

    public static String[] ReadProductInformation ( final String category, final String productID, final String productName )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return null;
        }

        String condition;

        if ( category != null && !category.isEmpty() )
        {
            condition = " WHERE \"Category\"='" + category + "'";

            if ( productID != null && !productID.isEmpty() )
            {
                condition += " AND \"Product ID\"='" + productID + "'";
            }
            else if ( productName != null && !productName.isEmpty() )
            {
                condition += " AND \"Name\"='" + productName + "'";
            }
        }
        else
        {
            if ( productID != null && !productID.isEmpty() )
            {
                condition = " WHERE \"Product ID\"='" + productID + "'";
            }
            else if ( productName != null && !productName.isEmpty() )
            {
                condition = " WHERE \"Name\"='" + productName + "'";
            }
            else
            {
                condition = "";
            }
        }

        final String sql = "SELECT \"Product ID\",\"Name\",\"Category\",\"Quantity\",\"Price\" FROM \"Product Information\"" + condition + " ORDER BY \"Category\" ASC,\"Product ID\" ASC";

        final ArrayList<String> alProductInformation = new ArrayList<>();

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql );
              final ResultSet rs = ps.executeQuery() )
        {
            while ( rs.next() )
            {
                final String dbProductID = rs.getString ( 1 );
                final String dbProductName = rs.getString ( 2 );
                final String dbCategory = rs.getString ( 3 );
                final int quantity = rs.getInt ( 4 );
                final double price = rs.getDouble ( 5 );
                alProductInformation.add ( dbProductID + "`" + dbProductName + "`" + dbCategory + "`" + quantity + "`" + price );
            }
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return null;
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return alProductInformation.toArray ( new String [ alProductInformation.size() ] );
    }

    public static String AddProduct ( final String productID, final String productName, final String category,
        final int quantity, final double price )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        final String sql = "INSERT INTO \"Product Information\" (\"Product ID\",\"Name\",\"Category\",\"Quantity\",\"Price\")" +
            " VALUES (?,?,?,?,?)";

        String output = "Success";

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql ) )
        {
            ps.setString ( 1, productID );
            ps.setString ( 2, productName );
            ps.setString ( 3, category );
            ps.setInt ( 4, quantity );
            ps.setDouble ( 5, price );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String UpdateProductInformation ( final String oldProductID, final String productID, final String productName,
        final String category, final int quantity, final double price )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        final String sql = "UPDATE \"Product Information\" SET \"Product ID\"=?,\"Name\"=?,\"Category\"=?,\"Quantity\"=?,\"Price\"=? WHERE \"Product ID\"=?";

        String output = "Success";

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql ) )
        {
            ps.setString ( 1, productID );
            ps.setString ( 2, productName );
            ps.setString ( 3, category );
            ps.setInt ( 4, quantity );
            ps.setDouble ( 5, price );
            ps.setString ( 6, oldProductID );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String UpdateProductQuantity ( final String productID, final int quantity )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        final String sql = "UPDATE \"Product Information\" SET \"Quantity\"=? WHERE \"Product ID\"=?";

        String output = "Success";

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql ) )
        {
            ps.setInt ( 1, quantity );
            ps.setString ( 2, productID );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String DeleteProduct ( final String productID )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        final String sql = "DELETE FROM \"Product Information\" WHERE \"Product ID\"=?";

        String output = "Success";

        try ( final PreparedStatement ps = Data.databaseLocal.GetPreparedStatement ( sql ) )
        {
            ps.setString ( 1, productID );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }

    public static String GenerateHistory ( final String studentUsername, final String filterBy, final String accountType )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        String html = "";

        final String sql;
        
        if ( !studentUsername.isEmpty() )
            sql = "SELECT \"Parcel ID\",to_char(\"Date of Purchase\",'DD MON YYYY'),\"Tracking ID\",\"Courier\",\"Collection Timestamp\" IS NOT NULL,to_char(\"Collection Timestamp\",'HH:MI PM'),\"Confirmation Status\" IS NOT NULL,\"Confirmation Status\" FROM \"Parcel Information\" WHERE \"Buyer\"=? ORDER BY \"" + filterBy + "\" ASC";
        else
            sql = "SELECT \"Parcel ID\",\"Buyer\",to_char(\"Date of Purchase\",'DD MON YYYY'),\"Tracking ID\",\"Courier\",\"Receiver\" IS NOT NULL,\"Receiver\",\"Collection Timestamp\" IS NOT NULL,to_char(\"Collection Timestamp\",'HH:MI PM'),\"Confirmation Status\" IS NOT NULL,\"Confirmation Status\" FROM \"Parcel Information\" ORDER BY \"" + filterBy + "\" ASC";

        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );

            if ( !studentUsername.isEmpty() )
                ps.setString ( 1, studentUsername );

            rs = ps.executeQuery();

            int index = 1;
            
            while ( rs.next() )
            {
                final long parcelID;
                final String buyer;
                final String dateOfPurchase;
                final String trackingID;
                final String courier;
                final String receiver;
                final String collected;
                final String timeCollect;

                if ( !studentUsername.isEmpty() )
                {
                    parcelID = rs.getLong ( 1 );
                    dateOfPurchase = rs.getString ( 2 );
                    trackingID = rs.getString ( 3 );
                    courier = rs.getString ( 4 );

                    if ( accountType.equals ( "User" ) )
                        collected = rs.getBoolean ( 7 ) ? rs.getString ( 8 ) : "<input type='button' class='buttons' value='Yes' style='width:48%' onclick='UpdateStatus(\"" + parcelID + "\",\"Yes\")' />&nbsp;<input type='button' class='buttons' value='No' style='width:48%' onclick='UpdateStatus(\"" + parcelID + "\",\"No\")' />";
                    else
                        collected = rs.getBoolean ( 7 ) ? rs.getString ( 8 ) : "Pending";

                    timeCollect = rs.getBoolean ( 5 ) ? rs.getString ( 6 ) : "N/A";

                    html += "<tr align='center'>" +
                            "    <td>" + index++ + "</td>" +
                            "    <td>" + dateOfPurchase + "</td>" +
                            "    <td>" + trackingID + "</td>" +
                            "    <td>" + collected + "</td>" +
                            "    <td>" + timeCollect + "</td>" +
                            "</tr>";
                }
                else
                {
                    parcelID = rs.getLong ( 1 );
                    buyer = rs.getString ( 2 );
                    dateOfPurchase = rs.getString ( 3 );
                    trackingID = rs.getString ( 4 );
                    courier = rs.getString ( 5 );
                    receiver = rs.getBoolean ( 6 ) ? rs.getString ( 7 ) : "N/A";

                    if ( accountType.equals ( "User" ) )
                        collected = rs.getBoolean ( 10 ) ? rs.getString ( 11 ) : "<input type='button' class='buttons' value='Yes' style='width:48%' onclick='UpdateStatus(\"" + parcelID + "\",\"Yes\")' />&nbsp;<input type='button' class='buttons' value='No' style='width:48%' onclick='UpdateStatus(\"" + parcelID + "\",\"No\")' />";
                    else
                        collected = rs.getBoolean ( 10 ) ? rs.getString ( 11 ) : "Pending";

                    timeCollect = rs.getBoolean ( 8 ) ? rs.getString ( 9 ) : "N/A";

                    html += "<tr align='center'>" +
                            "    <td>" + index++ + "</td>" +
                            "    <td>" + buyer + "</td>" +
                            "    <td>" + dateOfPurchase + "</td>" +
                            "    <td>" + trackingID + "</td>" +
                            "    <td>" + receiver + "</td>" +
                            "    <td>" + collected + "</td>" +
                            "    <td>" + timeCollect + "</td>" +
                            "</tr>";
                }
            }
            
            if ( !html.isEmpty() )
            {
                if ( !studentUsername.isEmpty() )
                {
                    html = "<table style='width:100%'>" +
                            "<tr>" +
                            "    <th><span class='buttons' style='width:100%'>No</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Date of Purchase</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Tracking ID</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Collected</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Time Collect</span></th>" +
                            "</tr>" + html +
                            "</table>";
                }
                else
                {
                    html = "<table style='width:100%'>" +
                            "<tr>" +
                            "    <th><span class='buttons' style='width:100%'>No</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Student Name</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Date of Purchase</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Tracking ID</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Received By</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Collected by Student</span></th>" +
                            "    <th><span class='buttons' style='width:100%'>Time Collect by Student</span></th>" +
                            "</tr>" + html +
                            "</table>";
                }
            }
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            html = e.getMessage();
        }
        finally
        {
            try
            {
                if ( rs != null ) rs.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return html;
    }

    public static String ClearHistory ( final String buyerUsername )
    {
        try
        {
            Data.databaseLocal.OpenDatabase();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            return e.getMessage();
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        final String sql;

        if ( !buyerUsername.isEmpty() )
            sql = "DELETE FROM \"Parcel Information\" WHERE \"Buyer\"='" + buyerUsername + "'";
        else
            sql = "DELETE FROM \"Parcel Information\"";

        String output = "Success";

        try
        {
            ps = Data.databaseLocal.GetPreparedStatement ( sql );

            ps.executeUpdate();
            Data.databaseLocal.Commit();
        }
        catch ( final SQLException e )
        {
            e.printStackTrace();
            output = e.getMessage();
        }
        finally
        {
            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( final SQLException e )
            {}

            try
            {
                Data.databaseLocal.CloseDatabase();
            }
            catch ( final SQLException e )
            {}
        }

        return output;
    }
}
