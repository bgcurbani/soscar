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
    /// Classe utilizada para gravação dos dados das Oficinas
    /// </summary>
    public class OficinaDataService
    {
        private DBConnection dbCon;

        public OficinaDataService()
        {
            dbCon = DBConnection.Instance();
            dbCon.IsConnect();
        }

        public bool CadastrarAvaliacao(Oficina of, Usuario user, string sAvaliacao, int iNota)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("INSERT INTO AVALIACAO (CD_USUARIO, ID_OFICINA, DS_AVALIACAO, NR_NOTA) VALUES ('{0}', '{1}', '{2}', '{3}')", user.Codigo, of.Id, sAvaliacao, iNota);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }

		public bool DeletarAvaliacao(int iCodigoAvaliacao)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("DELETE FROM AVALIACAO WHERE CD_AVALIACAO = '{0}'", iCodigoAvaliacao);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }
		
		public bool AtualizarAvaliacao(int iCodigoAvaliacao, string sAvaliacao, int iNota)
        {
            if (dbCon.IsConnect())
            {
                string query = string.Format("UPDATE AVALIACAO SET DS_AVALIACAO = '{0}', NR_NOTA = '{1}' WHERE CD_AVALIACAO = '{2}'", sAvaliacao, iNota, iCodigoAvaliacao);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                    return true;

                return false;
            }

            return false;
        }
		
        public bool GetcodigoAvaliacoes(string sIDOficina, ref string sCodigos)
        {
            Thread.Sleep(10);

            sCodigos = "";
            if (dbCon.IsConnect())
            {
                string query = string.Format("SELECT CD_AVALIACAO FROM AVALIACAO WHERE ID_OFICINA = '{0}'", sIDOficina);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    sCodigos += reader.GetInt32(0).ToString() + ",";
                }

                reader.Close();

                if (sCodigos != "")
                    sCodigos.Remove(sCodigos.Length - 1);

                return true;
            }

            return false;
        }

        public bool LeAvaliacao(string sCodigoAvaliacao, ref int iCodigoUsuario, ref string sAvaliacao, ref string iNota)
        {
            Thread.Sleep(100);
            sAvaliacao   = "";
            iCodigoUsuario = 0;
            iNota        = "";
            if (dbCon.IsConnect())
            {
                string query = string.Format("SELECT * FROM AVALIACAO WHERE CD_AVALIACAO = '{0}'", sCodigoAvaliacao);
                var cmd = new MySqlCommand(query, dbCon.Connection);
                cmd.Cancel();
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    iCodigoUsuario = reader.GetInt32(1);
                    sAvaliacao     = reader.GetString(3);
                    iNota          = reader.GetInt32(4).ToString() + "|" + reader.GetInt32(0).ToString();
                }

                reader.Close();
                return true;
            }

            return false;
        }
    }
}
