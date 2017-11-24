using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Objetos;
using System.Threading;

namespace DataService
{
    /// <summary>
    /// Classe utilizada para gravação dos dados dos Usuários
    /// </summary>
    /// Essa classe que se comunica com o banco de dados.
    public class UsuarioDataService
    {
        private DBConnection dbCon;

        public UsuarioDataService()
        {
            dbCon = DBConnection.Instance();
            dbCon.IsConnect();
        }

        public bool LoginUsuario(Usuario user) 
        {
            Thread.Sleep(10);

            if (dbCon.IsConnect())
            {
                string query = string.Format("SELECT * FROM USUARIO WHERE NM_LOGIN = '{0}' AND SE_SENHA = '{1}'", user.Login, user.Senha);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    int iCodigoCliente = reader.GetInt32(0);
                    string sUsuario = reader.GetString(1);
                    string sSenha = reader.GetString(2);
                    Console.WriteLine(sUsuario + "," + sSenha);

                    user.Codigo = iCodigoCliente;

                    reader.Close();
                    return true;
                }

                reader.Close();
                return false;
            }

            return false;
        }

        public bool LeUsuario(Usuario user)
        {
            Thread.Sleep(10);
            if (dbCon.IsConnect())
            {
                string query = string.Format("SELECT * FROM USUARIO WHERE CD_USUARIO = '{0}'", user.Codigo);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    user.Login = reader.GetString(1);
                    user.Senha = reader.GetString(2);

                    reader.Close();
                    return true;
                }

                reader.Close();
                return false;
            }

            return false;
        }

        public bool UsuarioExiste(Usuario user)
        {
            Thread.Sleep(10);

            if (dbCon.IsConnect())
            {
                string query = string.Format("SELECT * FROM USUARIO WHERE NM_LOGIN = '{0}'", user.Login);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    int iCodigoCliente = reader.GetInt32(0);
                    string sUsuario    = reader.GetString(1);
                    string sSenha      = reader.GetString(2);
                    Console.WriteLine(sUsuario + "," + sSenha);

                    user.Codigo = iCodigoCliente;

                    reader.Close();
                    return true;
                }

                reader.Close();
                return false;
            }

            return false;
        }

        public bool CadastrarUsuario(Usuario user)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("INSERT INTO USUARIO (NM_LOGIN, SE_SENHA) VALUES ('{0}', '{1}')", user.Login, user.Senha);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }

        public bool LerFavorito(int codigoCliente, string idOficina, ref bool bEhFavorito)
        {
            Thread.Sleep(10);

            if (dbCon.IsConnect())
            {
                bEhFavorito = false;
                string query = string.Format("SELECT ID_OFICINA FROM usuario_fav_oficina WHERE CD_USUARIO = '{0}' AND ID_OFICINA = '{1}'", codigoCliente, idOficina);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                    bEhFavorito = true;

                reader.Close();
                return true;
            }

            return false;
        }

        public bool GravarFavorito(int codigoCliente, string idOficina)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("INSERT INTO usuario_fav_oficina (CD_USUARIO, ID_OFICINA) VALUES ('{0}', '{1}')", codigoCliente, idOficina);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }

        public bool DeletarFavorito(int codigoCliente, string idOficina)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("DELETE FROM usuario_fav_oficina WHERE CD_USUARIO = '{0}' AND ID_OFICINA = '{1}'", codigoCliente, idOficina);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }

    }
}
