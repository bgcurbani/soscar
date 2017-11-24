using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Objetos;
using Biz;

namespace LocalizadorOficinas
{
    public partial class Caminhos : System.Web.UI.Page
    {
        Usuario usuarioLogado;

        protected void Page_Load(object sender, EventArgs e)
        {
            btnLogin.Click += new EventHandler(this.BtnLogin_Click);
            btnCadastrar.Click += new EventHandler(this.BtnCadastrar_Click);
        
        }

		[WebMethod]
        public static string AtualizarAvaliacao(string sCodigoAvaliacao, string sAvaliacao, string sNota)
        {
            OficinaBiz ofBiz = new OficinaBiz();

            int iNota = Int32.Parse(sNota);
			int iCodigo = Int32.Parse(sCodigoAvaliacao);

            if (!ofBiz.AtualizarAvaliacao(iCodigo, sAvaliacao, iNota))
                return "Não foi possível atualizar a avaliação.";

            return "Avaliação atualizada com sucesso.";
        }
		
		[WebMethod]
        public static string DeletarAvaliacao(string sCodigoAvaliacao)
        {
            OficinaBiz ofBiz = new OficinaBiz();

			int iCodigo = Int32.Parse(sCodigoAvaliacao);
			
            if (!ofBiz.DeletarAvaliacao(iCodigo))
                return "Não foi possível deletar a avaliação.";

            return "Avaliação deletada com sucesso.";
        }
		
        [WebMethod]
        public static string LeAvaliacao(string sCodigoAvaliacao)
        {
            OficinaBiz ofBiz = new OficinaBiz();

            string sUsuario = "";
            string sAvaliacao = "";
            string sNota = "";
            if (!ofBiz.LeAvaliacao(sCodigoAvaliacao, ref sUsuario, ref sAvaliacao, ref sNota))
                return "Não foi possível ler a avaliação cadastradas.";

            string sRetorno = sUsuario + "|" + sAvaliacao + "|" + sNota;
            return sRetorno;
        }

        [WebMethod]
        public static string GetCodigoAvaliacoes(string sIDOficina)
        {
            OficinaBiz ofBiz = new OficinaBiz();

            string sCodigos = "";
            if (!ofBiz.GetCodigoAvaliacoes(sIDOficina, ref sCodigos))
                return "Não foi possível buscar as avaliações cadastradas.";

            return sCodigos;
        }

        [WebMethod]
        public static string CadastrarAvaliacao(string sIDOficina, string sNomeUsuario, string sAvaliacao, string sNota)
        {
            OficinaBiz ofBiz = new OficinaBiz();

            int iNota = Int32.Parse(sNota);

            if (!ofBiz.CadastraAvaliacao(sIDOficina, sNomeUsuario, sAvaliacao, iNota))
                return "Não foi possível cadastrar a avaliação.";

            return "Avaliação cadastrada com sucesso.";
        }

        [WebMethod]
        public static string VerificaFavorito(string sIDOficina, string sNomeUsuario)
        {
            UsuarioBiz userBiz = new UsuarioBiz();

            string sFavorito = "";
            if (!userBiz.VerificaSeEhFavorito(sIDOficina, sNomeUsuario, ref sFavorito))
                return "N";

            if (sFavorito == "s")
                return "S";

            return "N";
        }

        [WebMethod]
        public static string FavoritarOficina(string sIDOficina, string sNomeUsuario, string sFavoritar)
        {
            UsuarioBiz userBiz = new UsuarioBiz();

            if (sFavoritar == "sim")
            {
                if (userBiz.FavoritarOficina(sIDOficina, sNomeUsuario, true))
                    return "Favoritado com sucesso";
            }
            else
            {
                if (userBiz.FavoritarOficina(sIDOficina, sNomeUsuario, false))
                    return "Desfavoritado com sucesso";
            }

            return "Não foi possível efetuar a alteração.";
        }

        public void BtnLogin_Click(object sender, EventArgs e)
        {
            string sLogin = txtLogin.Text.Trim();
            string sSenha = txtPassword.Text.Trim();

            Usuario usuario = new Usuario();
            usuario.Login = sLogin;
            usuario.Senha = sSenha;

            UsuarioBiz userBiz = new UsuarioBiz();
            if (userBiz.LoginUsuario(usuario))
            {
                usuarioLogado = usuario;

                lblUsuario.Visible = true;
                lblUsuario.Text = usuario.Login;

                txtLogin.Visible = false;
                txtPassword.Visible = false;
                lblLogin.Visible = false;
                lblPassword.Visible = false;
                btnCadastrar.Visible = false;
                btnLogin.Visible = false;
            }
            else
            {
                
                // TODO: Exibir mensagem que o usuário não está cadastrado;
            }
        }

        protected void BtnCadastrar_Click(object sender, EventArgs e)
        {
            string sLogin = txtLogin.Text.Trim();
            string sSenha = txtPassword.Text.Trim();

            Objetos.Usuario usuario = new Objetos.Usuario();
            usuario.Login = sLogin;
            usuario.Senha = sSenha;

            UsuarioBiz userBiz = new UsuarioBiz();
            if (userBiz.CadastraUsuario(usuario))
            {
                // TODO: Exibir mensagem de usuario cadastrado com sucesso;
            }
            else
            {
                // TODO: Exibir mensagem que o usuário já está cadastrado;
            }
        }
    }
}