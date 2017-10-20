using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Objetos
{
    public class Oficina
    {
        Endereco endereco;

        public int Id { get; set; }

        public string Nome { get; set; }

        public double NotaGeral { get; set; }

        public Endereco Endereco
        {
            get { return endereco ?? (endereco = new Endereco()); }
            set { endereco = value; }
        }
    }
}
