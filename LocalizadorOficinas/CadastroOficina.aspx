<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CadastroOficina.aspx.cs" Inherits="LocalizadorOficinas.CadastroOficina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 418px;
        }
    </style>
</head>
<body>
    <form id="formCadastro" runat="server">
    <div>
    
    </div>
        <asp:Label ID="Label1" runat="server" Text="Nome:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="NomeTextBox" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Cidade:"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="CidadeTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label4" runat="server" Text="Bairro:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="BairroTextBox" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Rua:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="RuaTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label6" runat="server" Text="Número:"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="NumeroTextBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="CEP:"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="CEPTextBox" runat="server"></asp:TextBox>
    </form>
</body>
</html>
