from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta

app = Flask(__name__)
app.secret_key = 'chave_secreta'  # Sempre troque essa chave para algo mais seguro

# Configuração do banco de dados
conn = mysql.connector.connect(
    host='localhost',
    user='root',  # Altere conforme necessário
    password='senha',  # Adicione sua senha se houver
    database=''
)
cursor = conn.cursor(dictionary=True)


from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'sua_chave_secreta_aqui'

# Configuração do banco de dados
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="35200983",
    database="clinica"
)
cursor = conn.cursor(dictionary=True)

@app.route('/', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        try:
            # Obter dados do formulário
            nome = request.form['nome']
            cpf = request.form['cpf']
            data_nascimento = request.form['data_nascimento']  # Certifique-se de que o nome está correto
            telefone = request.form['telefone']
            email = request.form['email']
            ficha_medica = request.form['ficha_medica']

            # Verificar se o CPF já existe no banco de dados
            cursor.execute('SELECT * FROM Pacientes WHERE cpf = %s', (cpf,))
            usuario_existente = cursor.fetchone()

            if usuario_existente:
                flash("Já existe um usuário cadastrado com este CPF. Por favor, utilize outro CPF.", "error")
                return redirect(url_for('cadastro'))

            # Inserir o novo paciente no banco de dados
            sql = """
                INSERT INTO Pacientes (nome, cpf, data_nascimento, telefone, email, ficha_medica)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            valores = (nome, cpf, data_nascimento, telefone, email, ficha_medica)
            cursor.execute(sql, valores)
            conn.commit()

            flash("Cadastro realizado com sucesso! Faça login para continuar.", "success")
            return redirect(url_for('login'))

        except Exception as e:
            conn.rollback()  # Desfaz a transação em caso de erro
            flash(f"Erro ao cadastrar usuário: {str(e)}", "error")
            return redirect(url_for('cadastro'))

    return render_template('cadastro.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']  # Nome do usuário
        senha = request.form['senha']        # CPF do usuário

        # Verifica se o nome e o CPF correspondem a um usuário na tabela `Pacientes`
        cursor.execute('SELECT * FROM Pacientes WHERE nome = %s AND cpf = %s', (username, senha))
        user = cursor.fetchone()

        if user:
            # Login bem-sucedido
            session['username'] = username
            flash(f'Bem-vindo, {username}!', 'success')
            return redirect(url_for('pagina_usuario'))  # Redireciona para a página do usuário
        else:
            # Login falhou
            flash('Nome de usuário ou CPF incorretos!', 'error')

    return render_template('login.html')

def obter_horarios_disponiveis(medico_id, data_consulta):
    try:
        # Verificar consultas já agendadas para o médico na data escolhida
        sql = """
            SELECT hora_consulta FROM Consultas
            WHERE medico_id = %s AND data_consulta = %s
        """
        cursor.execute(sql, (medico_id, data_consulta))
        consultas_agendadas = cursor.fetchall()

        # Definir horários de trabalho do médico (exemplo: das 9h às 17h)
        horarios_trabalho = [
            datetime.strptime('09:00', '%H:%M') + timedelta(minutes=30 * i) for i in range(16)
        ]

        # Filtrar horários disponíveis
        horarios_agendados = [datetime.strptime(consulta[0], '%H:%M:%S') for consulta in consultas_agendadas]
        horarios_disponiveis = [
            horario.strftime('%H:%M') for horario in horarios_trabalho
            if horario not in horarios_agendados
        ]

        return horarios_disponiveis

    except Exception as e:
        print(f"Erro ao obter horários disponíveis: {e}")
        return []

@app.route('/marcar_consulta', methods=['GET', 'POST'])
def marcar_consulta():
    cursor.execute('SELECT id, nome FROM Medicos')
    medicos = cursor.fetchall()  # Isso irá buscar todos os médicos no banco de dados

    if request.method == 'POST':
        try:
            # Dados do formulário
            medico_id = request.form.get('medico')
            data_consulta = request.form.get('data_consulta')

            if not medico_id or not data_consulta:
                flash("Selecione um médico e uma data.", "error")
                return redirect(url_for('marcar_consulta'))

            # Buscar horários disponíveis para o médico na data escolhida
            horarios_disponiveis = obter_horarios_disponiveis(medico_id, data_consulta)

            if not horarios_disponiveis:
                flash("Não há horários disponíveis para o médico na data escolhida.", "error")
                return redirect(url_for('marcar_consulta'))

            # Renderizar o template com os horários disponíveis
            return render_template('marcar_consulta.html', medicos=medicos, horarios_disponiveis=horarios_disponiveis)

        except Exception as e:
            flash(f"Erro ao processar a solicitação: {str(e)}", "error")
            return redirect(url_for('marcar_consulta'))

    else:
        # Se for uma requisição GET, apenas exibir o formulário
        return render_template('marcar_consulta.html', medicos=medicos)

@app.route('/salvar_consulta', methods=['POST'])
def salvar_consulta():
    if request.method == 'POST':
        try:
            # Obter o ID do paciente logado (substitua pela lógica de autenticação)
            if 'username' in session:
                cursor.execute('SELECT id FROM Pacientes WHERE nome = %s', (session['username'],))
                paciente = cursor.fetchone()
                if not paciente:
                    flash("Paciente não encontrado.", "error")
                    return redirect(url_for('marcar_consulta'))
                paciente_id = paciente['id']
            else:
                flash("Você precisa fazer login para marcar uma consulta.", "error")
                return redirect(url_for('login'))

            # Obter dados do formulário
            medico_id = request.form['medico']
            data_consulta = request.form['data_consulta']
            hora_consulta = request.form['hora_consulta']
            observacoes = request.form.get('observacoes', 'Consulta agendada pelo paciente.')

            # Inserir a consulta no banco de dados
            sql = """
                INSERT INTO Consultas (paciente_id, medico_id, data_consulta, hora_consulta, observacoes)
                VALUES (%s, %s, %s, %s, %s)
            """
            valores = (paciente_id, medico_id, data_consulta, hora_consulta, observacoes)
            cursor.execute(sql, valores)
            conn.commit()

            flash('Consulta marcada com sucesso!', 'success')
            return redirect(url_for('home'))  # Redireciona para a página inicial

        except Exception as e:
            conn.rollback()  # Desfaz a transação em caso de erro
            flash(f"Erro ao marcar consulta: {str(e)}", "error")
            return redirect(url_for('marcar_consulta'))

from datetime import datetime, timedelta
from flask import jsonify, request

@app.route('/verificar_horarios', methods=['GET'])
def verificar_horarios():
    try:
        # Obter parâmetros da URL
        medico_id = request.args.get('medico_id')
        data_consulta = request.args.get('data_consulta')

        # Verificar se os parâmetros foram fornecidos
        if not medico_id or not data_consulta:
            return jsonify({"error": "Médico e data são obrigatórios."}), 400

        # Converter a data para o formato do banco de dados (YYYY-MM-DD)
        data_consulta_formatada = datetime.strptime(data_consulta, '%Y-%m-%d').date()

        # Buscar consultas já agendadas para o médico na data escolhida
        sql = """
            SELECT hora_consulta FROM Consultas
            WHERE medico_id = %s AND data_consulta = %s
        """
        cursor.execute(sql, (medico_id, data_consulta_formatada))
        consultas_agendadas = cursor.fetchall()

        # Definir horários de trabalho do médico (exemplo: das 9h às 17h)
        horarios_trabalho = [
            (datetime.strptime('09:00', '%H:%M') + timedelta(minutes=30 * i)).time()
            for i in range(16)  # 16 horários de 30 minutos entre 9h e 17h
        ]

        # Filtrar horários disponíveis
        horarios_agendados = [datetime.strptime(consulta['hora_consulta'], '%H:%M:%S').time() for consulta in consultas_agendadas]
        horarios_disponiveis = [
            horario.strftime('%H:%M') for horario in horarios_trabalho
            if horario not in horarios_agendados
        ]

        return jsonify({"horarios_disponiveis": horarios_disponiveis})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/ver_relatorio', methods=['GET'])
def ver_relatorio():
    if 'username' in session:  # Verifica se o usuário está logado
        try:
            print("Session username:", session['username'])  # Debug: imprime o username da sessão

            # Consultar os dados do paciente logado usando o nome armazenado na sessão
            cursor.execute('SELECT id, nome, cpf FROM Pacientes WHERE nome = %s', (session['username'],))
            paciente = cursor.fetchone()
            print("Paciente encontrado:", paciente)  # Debug: imprime os dados do paciente

            if paciente:
                paciente_id, nome, cpf = paciente['id'], paciente['nome'], paciente['cpf']

                # Consultar as consultas feitas pelo paciente e as observações dos médicos
                cursor.execute("""
                    SELECT Medicos.nome AS medico_nome, Consultas.observacoes, 
                           Consultas.data_consulta, Consultas.hora_consulta
                    FROM Consultas
                    JOIN Medicos ON Consultas.medico_id = Medicos.id
                    WHERE Consultas.paciente_id = %s
                """, (paciente_id,))
                consultas = cursor.fetchall()
                print("Consultas encontradas:", consultas)  # Debug: imprime as consultas encontradas

                if consultas:
                    return render_template('ver_relatorio.html', nome=nome, cpf=cpf, consultas=consultas)
                else:
                    flash("Este paciente não possui consultas registradas.", "info")
                    return redirect(url_for('pagina_usuario'))
            else:
                flash("Paciente não encontrado.", "error")
                return redirect(url_for('login'))
        except Exception as e:
            flash(f"Erro ao gerar o relatório: {str(e)}", "error")
            return redirect(url_for('pagina_usuario'))
    else:
        flash("Você precisa fazer login para acessar esta página.", "error")
        return redirect(url_for('login'))



@app.route('/pagina_usuario')
def pagina_usuario():
    if 'username' in session:  # Verifica se o usuário está logado
        # Consultar o nome e CPF do usuário no banco de dados usando o nome
        cursor.execute('SELECT nome, cpf FROM Pacientes WHERE nome = %s', (session['username'],))
        user = cursor.fetchone()

        if user:
            nome, cpf = user
            return render_template('pagina_usuario.html', username=nome, cpf=cpf)  # Passa as variáveis para o HTML
        else:
            flash("Usuário não encontrado.", "error")
            return redirect(url_for('login'))  # Caso o usuário não seja encontrado no banco de dados
    else:
        flash("Você precisa fazer login para acessar esta página.", "error")
        return redirect(url_for('login'))  # Redireciona para login caso o usuário não esteja logado

if __name__ == '__main__':
    app.run(debug=True)
