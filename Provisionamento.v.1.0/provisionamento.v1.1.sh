#! /bin/bash


################FUNÇÕES#############################


#-------------------APPS-----------------------#

#função p/ instalar apache
inst_apache() {
	apt install apache2 -y
	systemctl enable apache2
	echo "sistema apache instalado com sucesso, verifique seu ip: $(hostname -I)"
}

#função para instalar o mysql
inst_mysql() {
	apt install mysql-server-8.0 -y
	echo "MySQL instalado"
}

#--------------------GRUPOS---------------------#

grp_adm(){
	mkdir -p /adm
	groupadd GRP_ADM
	chmod 770 /adm
	chown root:GRP_ADM /adm
	echo "Grupo ADM criado"
}

grp_sec(){
	mkdir -p /sec
	groupadd GRP_SEC
	chmod 770 /sec
	chown root:GRP_SEC /sec
	echo "Grupo SEC criado"
}

grp_ven(){
	mkdir -p /ven
	groupadd GRP_VEN
	chmod 770 /ven
	chown root:GRP_VEN /ven
	echo "Grupo VEN criado"
}

grp_cont(){
	mkdir -p /cont
	groupadd GRP_CONT
	chmod 770 /cont
	chown root:GRP_CONT /cont
	echo "Grupo CONT criado"
}

#----------------USUARIOS|Beta-------------#

add_user(){
	useradd "$1" -m -G "GRP_$2" -s /bin/bash
	echo "Usuário $1 adicionado ao grupo GRP_$2 "
}


#-----------MENUS (GRUPOS)-------------#

menu_grp(){
echo "Escolha a primeira pasta do escritório do sistema "
select opt in "Administrativo" "Segurança" "Vendas" "Contabilidade" "Finalizar" ; do
	case $opt in
  	 "Administrativo") grp_adm ;  menu_grp ;;
	 "Segurança") grp_sec ; menu_grp ;;
         "Vendas") grp_ven ; menu_grp ;;
         "Contabilidade") grp_cont ; menu_grp ;;
	 "Finalizar") break ;;
  	 *) echo "opção invalida" ;;
	 esac
	break
done
}


#------------Menu Sistemas----------#
menu_app1(){
echo "Selecione o sistema para ser adicionado: "
select opt in "Apache" "MySql" "Done" ; do
	case $opt in
	"Apache") inst_apache ; menu_app1 ;;
	"MySql") inst_mysql ; menu app_1 ;;
	"Done") break ;;
	*  ) echo "opção invalida"
	esac
	break
done
}
#-----------Menu Usuários------------#

menu_user(){
	echo "---Cadastro de usuários---"

	##nome do usuario
	read -p "Digite o nome de usuário:  " username
	#selecionar grupo
	echo "selecione o Grupo:"
   	  select grupo in "ADM" "VEN" "SEC" "CONT" "Cancelar" ;do
		case $grupo in
			 "ADM" | "VEN" | "SEC" | "CONT")
				add_user "$username" "$grupo"
				read -p "pressione ENTER para continuar..."
				break
				;;
			"Cancelar")
				echo "Cancelado!"
				break
				;;
			* ) 	echo "Opção Inválida!"
		esac
	  done

}
#----------------MENU PRINCIPAL-----------#
while true; do
    echo ""
    echo "=== MENU PRINCIPAL ==="
    select opt in "Criar Grupos" "Cadastrar Usuários" "Instalar Pacotes" "Sair"; do
        case $opt in
            "Criar Grupos")    menu_grp  ;;
            "Cadastrar Usuários") menu_user  ;;
	    "Instalar Pacotes") menu_app1 ;;
            "Sair")           exit 0 ;;
            *)                echo "Opção inválida!" ;;
        esac
	break
    done
done

