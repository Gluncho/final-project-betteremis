package DAO;

import DAO.Interfaces.FriendsDAO;
import Model.USERTYPE;
import Model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SqlFriendsDAO implements FriendsDAO {


    /*
    Updated tsima's freindsDAO and refactored names.
     */

    private ConnectionPool pool;
    private SqlUserDAO userDAO;

    public SqlFriendsDAO(ConnectionPool pool) {
        this.pool = pool;
        userDAO = new SqlUserDAO(pool);
    }

    @Override
    public boolean AreFriends(User user1, User user2,boolean mode){
        int id1 = userDAO.getIDByEmail(user1.getEmail());
        int id2 = userDAO.getIDByEmail(user2.getEmail());
        Connection conn = pool.getConnection();
        try {
            String query = "SELECT * FROM "  + (mode? "FRIENDS" : "FRIEND_REQS")
                    + " WHERE UserID = ? and FriendID = ? ";
            PreparedStatement stm = conn.prepareStatement(query);
            stm.setInt(1, id1); stm.setInt(2, id2);
            ResultSet res = stm.executeQuery();
            if(res.next()) return true;
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            pool.releaseConnection(conn);
        }
    }
    @Override
    public boolean AddFriend(User user1, User user2, boolean mode) {
        if(AreFriends(user1,user2,mode)) return false;
        if(mode==false&&AreFriends(user1,user2,true)) return false;
        int id1 = userDAO.getIDByEmail(user1.getEmail());
        int id2 = userDAO.getIDByEmail(user2.getEmail());
        Connection conn = pool.getConnection();
        if(mode==true)
            Remove(user1,user2,false);// remove from requests
        try {
            String query = "INSERT IGNORE INTO "  + (mode? "FRIENDS" : "FRIEND_REQS")
                + " (UserID, FriendID) VALUES (? , ?) ";
            PreparedStatement stm = conn.prepareStatement(query);
            stm.setInt(1, id1); stm.setInt(2, id2);
            int res = stm.executeUpdate();
            if(res == 1) return true;
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            pool.releaseConnection(conn);
        }
    }

    @Override
    public boolean Remove(User user1, User user2, boolean mode) {
        int id1 = userDAO.getIDByEmail(user1.getEmail());
        int id2 = userDAO.getIDByEmail(user2.getEmail());
        Connection conn = pool.getConnection();
        try {
            String query = "DELETE FROM " + (mode? "FRIENDS":"FRIEND_REQS") + " WHERE UserID = ? and FriendID = ?;";
            PreparedStatement stm = conn.prepareStatement(query);
            stm.setInt(1, id1); stm.setInt(2, id2);
            int res = stm.executeUpdate();
            if(res == 1) return true;
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            pool.releaseConnection(conn);
        }
    }

    @Override
    public List<User> GetAllFriends(User user, boolean mode) {
        List<User> res = new ArrayList<>();
        int id = userDAO.getIDByEmail(user.getEmail());
        Connection conn = pool.getConnection();
        try {
            String query = "SELECT U.Email, U.PasswordHash, U.Privilege FROM USERS U JOIN "+
                    (mode? " FRIENDS F " : "FRIEND_REQS F ") + " ON U.ID = F.FriendID WHERE F.UserID = ? ;";
            PreparedStatement stm = conn.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet set = stm.executeQuery();
            while(set.next()){
                res.add(new User(set.getString(1),set.getString(2),
                        USERTYPE.toUserType(set.getString(3))));
            }
            String query2 = "SELECT U.Email, U.PasswordHash, U.Privilege FROM USERS U JOIN "+
                    (mode? " FRIENDS F " : "FRIEND_REQS F ") + " ON U.ID = F.UserID WHERE F.FriendID = ? ;";
            PreparedStatement stm2 = conn.prepareStatement(query2);
            stm2.setInt(1, id);
            ResultSet set2 = stm2.executeQuery();
            while(set2.next()){
                res.add(new User(set2.getString(1),set2.getString(2),
                        USERTYPE.toUserType(set2.getString(3))));
            }
            return res;
        } catch (SQLException e) {
            return null;
        } finally {
            pool.releaseConnection(conn);
        }
    }
}
