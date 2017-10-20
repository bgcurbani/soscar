using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Objetos
{
    public class Usuario
    {
        List<Oficina> favoritos;

        public string Login { get; set; }

        public string Senha { get; set; }

        public List<Oficina> Favoritos
        {
            get { return favoritos ?? (favoritos = new List<Oficina>()); }
            set { favoritos = value; }
        }
    }
}
