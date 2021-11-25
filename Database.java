package InventoryManagementSystem;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Array;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.imageio.ImageIO;
import org.postgresql.jdbc.PgConnection;
import org.postgresql.largeobject.LargeObject;
import org.postgresql.largeobject.LargeObjectManager;

public class Database
{
    private PgConnection connection = null;

    private final static int dbPort = 5432;
    private String dbName = "Inventory Management System";
    private final static String dbUsername = "postgres";
    private final static String dbPassword = "postgres";

    private String connStr = "jdbc:postgresql://localhost:" + dbPort + "/" + dbName + "?user=" + dbUsername + "&password=" + dbPassword;

    public static void InitDatabase()
    {
        try
        {
            Class.forName ( "org.postgresql.Driver" );
        }
        catch ( final ClassNotFoundException e )
        {
            e.printStackTrace();
        }
    }

    public Database()
    {}

    public Database ( final String serverAddress, final String dbName )
    {
        this.dbName = dbName;
        connStr = "jdbc:postgresql://" + serverAddress + ":" + dbPort + "/" + dbName + "?user=" + dbUsername + "&password=" + dbPassword;
    }
    
    public void OpenDatabase() throws SQLException
    {
        CloseDatabase();

        DriverManager.setLoginTimeout ( 100 );
        connection = ( PgConnection ) DriverManager.getConnection ( connStr );
        
        connection.setAutoCommit ( false );
    }

    public PreparedStatement GetPreparedStatement ( final String sql ) throws SQLException
    {
        return connection.prepareStatement ( sql );
    }

    public long NonQueryDatabase ( final PreparedStatement ps ) throws SQLException
    {
        long newID = -1;
        
        ResultSet rs = null;
        
        SQLException sqlException = null;

        try
        {
            rs = ps.executeQuery();

            rs.next();
            
            newID = rs.getLong(1);
        }
        catch ( SQLException e )
        {
            sqlException = e;
        }
        finally
        {
            try
            {
                if ( rs != null ) rs.close();
            }
            catch ( SQLException e )
            {}

            try
            {
                if ( ps != null ) ps.close();
            }
            catch ( SQLException e )
            {}
        }

        if ( sqlException != null )
            throw sqlException;

        return newID;
    }
    
    public void Commit() throws SQLException
    {
        connection.commit();
    }

    public void UnlinkLargeObject ( final long oid ) throws SQLException, IOException
    {
        final LargeObjectManager lobj = connection.getLargeObjectAPI();

        lobj.unlink ( oid );
    }

    public ByteArrayInputStream BufferedImageToInputStream ( final BufferedImage img ) throws IOException
    {
        //final byte[] buffer = ( ( DataBufferByte ) ( img ).getRaster().getDataBuffer() ).getData();

        //return new ByteArrayInputStream ( buffer );
        final ByteArrayOutputStream os = new ByteArrayOutputStream();

        ImageIO.write ( img, "png", os ); // Passing: ​(RenderedImage im, String formatName, OutputStream output)

        return new ByteArrayInputStream ( os.toByteArray() );
    }

    public long WriteLargeObject ( final InputStream inputStream ) throws SQLException, IOException
    {
        final LargeObjectManager lobj = connection.getLargeObjectAPI();
        
        final long oid = lobj.createLO ( LargeObjectManager.READ | LargeObjectManager.WRITE );
        
        final LargeObject obj = lobj.open ( oid, LargeObjectManager.WRITE );
        
        final byte buf[] = new byte [ 2048 ];
        int data;

        while ( ( data = inputStream.read ( buf, 0, 2048 ) ) > 0 )
            obj.write ( buf, 0, data );
        
        obj.close();

        connection.commit();

        return oid;
    }

    public BufferedImage LoadImage ( final long oid ) throws SQLException, IOException
    {
        final LargeObjectManager lobj = connection.getLargeObjectAPI();

        final LargeObject objPicture = lobj.open ( oid, LargeObjectManager.READ );
        
        final byte[] bufPicture = new byte [ objPicture.size() ];
        objPicture.read ( bufPicture, 0, objPicture.size() );
        objPicture.close();
        
        final BufferedImage bImage = ImageIO.read ( new ByteArrayInputStream ( bufPicture ) );

        return bImage;
    }
    
    public File LoadAudio ( final long oid ) throws SQLException, IOException
    {
        final LargeObjectManager lobj = connection.getLargeObjectAPI();

        final LargeObject objAudio = lobj.open ( oid, LargeObjectManager.READ );
        
        final byte[] bufAudio = new byte [ objAudio.size() ];
        objAudio.read ( bufAudio, 0, objAudio.size() );
        objAudio.close();
        
        final File tempMp3 = File.createTempFile ( "VACA", ".mp3", null ); //, getCacheDir()
        tempMp3.deleteOnExit();

        final FileOutputStream fos = new FileOutputStream ( tempMp3 );
        fos.write ( bufAudio );
        fos.close();

        return tempMp3;
    }

    public Array CreateArrayOf ( final String type, final Object[] values ) throws SQLException
    {
        return connection.createArrayOf ( type, values );
    }

    public void CloseDatabase() throws SQLException
    {
        if ( connection != null )
        {
            connection.close();
            connection = null;
        }
    }
}
