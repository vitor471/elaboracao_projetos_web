<?php
//se conectar ao banco de dados
require_once __DIR__ . "/conexao.php";

//função para capturar os dados passados de uma página a outra  
function redirecwhith($url,$params=[]){
    //verifica se os parametros não vieram vazios
    if(!empty($params)){
        //separar os parametros em espaços diferentes
        $qs= http_build_query($params);
        $sep =(strpos($url,'?') === false) ?'?': '&';
        $url .= $sep .$qs;
}
header("location: $url");
// fecha script
exit;
}

//capturando os dados e jogando em variaveis
try{
    // se o metodo de envio for diferente do post
    if($_SERVER["request_method"]!== "post"){
        //voltar para tela de cadastro e exibir o erro
        redirecwhith("../paginas/cadastro.html",
        ["erro"=> "metodo invalido"]);
    }
    //jogando os dados dentro de variaveis
    $nome = $_POST["nome"];
    $email =$_POST["email"];
    $senha =$_POST["senha"];
    $telefone =$_POST["telefone"];
    $cpf =$_POST["cpf"];
    $confirmasenha = $_POST["confirmar"];

    //validando os campos
    // criar uma variavel para receber os erros de validação
    $erros_validacao=[];
    //se qualquer um campo for vazio
    if($nome === ""|| $email==="" || $senha ===""
    || $telefone ==="" || $cpf ==="" || $confirmarsenha===""){
        $erros_validacao[]="preencha todos os campos";
    }
    //validação para verificar se o email tem @
    if(!filter_var($email, filter_validate_email)){
        $erros_validacao[]= "E-mail inválido";,
    }
    
    if($senha !== $confirmarsenha){
        $erros_validacao[]= "As senhas não coferem";
    }
    //verificar se a senha tem mais de 8 digitos
    if(strlen($senha)<8){
        $erros_validacao[]="senha deve ter pelo menos 8 caracteres";
    }
    //verificar se o telefone tem pelo menos 11 digitos
    if(strlen($telefone)<11){
        $erros_validacao[]= "telefone incorreto";
    }
    //verificar se o cpf tem pelo menos 11 digitos
    if(strlen($cpf)<11){
        $erros_validacao[]= "cpf invalido";
    }
    //agora é enviar os erros para tela de cadastro
    if($erros_validacao){
        redirecwhith("../paginas/cadastro.html",
        ["erro" => urlencode($erros_validacao[0])]);
    }

    //verificar se o cpf já foi  cadastro no banco de dados
    $stmt = $pdo->prepare("select * from cliente
    where cpf= :cpf LIMIT 1");
    //joga o cpf digitado dentro do banco de dados
    $stmt ->execute([':cpf =>$cpf'])
    if($stmt ->fetch()){
        redirecwhith('../paginas/cadasto.html',["erro"
        => urldecode(CPF já cadastrado)])
    }

}


?>