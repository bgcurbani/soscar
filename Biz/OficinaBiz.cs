using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataService;
using Objetos;

namespace Biz
{
    /// <summary>
    /// Classe utilizada para validação das regras de negócio das Oficinas
    /// </summary>
    public class OficinaBiz
    {
        private OficinaDataService dataService;

        public OficinaBiz()
        {
            dataService = new OficinaDataService();
        }

        public bool CadastraAvaliacao(string sIDOficina, string sNomeUsuario, string sAvaliacao, int iNota)
        {
            UsuarioDataService userDataService = new UsuarioDataService();
            Usuario user = new Usuario();
            user.Login = sNomeUsuario;

            if (!userDataService.UsuarioExiste(user))
                return false;

            Oficina of = new Oficina();
            of.Id = sIDOficina;

            if (!dataService.CadastrarAvaliacao(of, user, sAvaliacao, iNota))
                return false;

            return true;
        }
		
		public bool DeletarAvaliacao(int iCodigoAvaliacao)
		{
			if (!dataService.DeletarAvaliacao(iCodigoAvaliacao))
                return false;
			
			return true;
		}
		
		public bool AtualizarAvaliacao(int iCodigoAvaliacao, string sAvaliacao, int iNota)
		{
			if (!dataService.AtualizarAvaliacao(iCodigoAvaliacao, sAvaliacao, iNota))
                return false;
			
			return true;
		}

        public bool GetCodigoAvaliacoes(string sIDOficina, ref string sCodigos)
        {
            if (!dataService.GetcodigoAvaliacoes(sIDOficina, ref sCodigos))
                return false;

            return true;
        }

        public bool LeAvaliacao(string sCodigoAvaliacao, ref string sUsuario, ref string sAvaliacao, ref string sNota)
        {
            int iCodigoUsuario = 0;
            if (!dataService.LeAvaliacao(sCodigoAvaliacao, ref iCodigoUsuario, ref sAvaliacao, ref sNota))
                return false;

            UsuarioDataService userDataService = new UsuarioDataService();
            Usuario user = new Usuario();
            user.Codigo = iCodigoUsuario;

            if (!userDataService.LeUsuario(user))
                return false;

            sUsuario = user.Login;

            return true;
        }
    }
}
