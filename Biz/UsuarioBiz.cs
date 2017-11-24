using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Objetos;
using DataService;

namespace Biz
{
    /// <summary>
    /// Classe utilizada para validação das regras de negócio dos Usuários
    /// </summary>
    public class UsuarioBiz
    {
        private UsuarioDataService usuarioDataService;

        public UsuarioBiz()
        {
            usuarioDataService = new UsuarioDataService();
        }

        public bool VerificaSeEhFavorito(string sIDOficina, string sNomeUsuario, ref string sFavorito)
        {
            Usuario user = new Usuario();
            user.Login = sNomeUsuario;

            if (!usuarioDataService.UsuarioExiste(user))
                return false;

            bool bEhFavorito = false;
            if (!usuarioDataService.LerFavorito(user.Codigo, sIDOficina, ref bEhFavorito))
                return false;

            if (bEhFavorito)
                sFavorito = "s";
            else
                sFavorito = "n";

            return true;
        }

        public bool FavoritarOficina(string sIDOficina, string sNomeUsuario, bool bFavoritar)
        {
            Usuario user = new Usuario();
            user.Login = sNomeUsuario;

            if (!usuarioDataService.UsuarioExiste(user))
                return false;

            if (bFavoritar)
                return usuarioDataService.GravarFavorito(user.Codigo, sIDOficina);
            else
                return usuarioDataService.DeletarFavorito(user.Codigo, sIDOficina);
        }

        public bool LoginUsuario(Usuario user)
        {
            if (!usuarioDataService.LoginUsuario(user))
                return false;

            return true;
        }

        public bool CadastraUsuario(Usuario user)
        {
            if (usuarioDataService.UsuarioExiste(user))
                return false;

            if (usuarioDataService.CadastrarUsuario(user))
                return true;
                
            return false;
        }
    }
}
