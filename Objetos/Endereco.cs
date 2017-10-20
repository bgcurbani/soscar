using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Objetos
{
    public class Endereco
    {
        public string PlaceId { get; set; }

        public int Latitude { get; set; }

        public int Longitude { get; set; }

        public string NomeBusca { get; set; }

        public string Rua { get; set; }

        public int Numero { get; set; }

        public string Cidade { get; set; }

        public string Bairro { get; set; }


        public string ToFormattedString()
        {
            return $"Rua {Rua}, {Numero}. Bairro {Bairro} Cidade {Cidade}.";
        }
    }
}
