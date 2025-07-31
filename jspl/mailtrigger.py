import psycopg2
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import configparser

def read_file(filepath = 'config.properties'):
    config  = configparser.ConfigParser()
    config.read(filepath)
    return config['EMAIL']

def fetch_data_from_db():
    my_data = []
    conn = psycopg2.connect(
        dbname="ssd_db",
        user="remoteuser",
        password="Remote@123",
        host="10.36.0.134"
    )

    cur = conn.cursor()
    query = """
    select pd.job_no, pd.planning_refno , pr.handover_to_painting , ps.final_insp_offer
    from dbo.planning_drawing pd 
    join dbo.painting_section ps
	    on ps.planning_refno = pd.planning_refno
    join dbo.production pr
	    on pr.planning_refno = pd.planning_refno
    where pr.handover_to_painting <= to_char(current_date , 'yyyy-mm-dd')
	    and ps.final_insp_offer is null
	    and pr.handover_to_painting is not null
	    and pr.handover_to_painting <> '';
    """
    cur.execute(query)
    my_data = cur.fetchall()
    cur.close()
    conn.close()
    return my_data

def send_mail(receiver_mail , body):
    config = read_file()
    SMTP_SERVER = config.get('smtp_host')  #SERVER URL#
    SMTP_PORT = config.getint('smtp_port')  # port of the smtp ss
    SENDER_EMAIL =  config.get('mail_from')# MAIL OF sender person
    # RECEIVER_MAIL = config.get('mail_to')

    msg = MIMEMultipart()
    msg['From'] = SENDER_EMAIL
    # msg['To'] = receiver_mail
    msg['Subject'] = "regardig your document varification"
    msg.attach(MIMEText(body , 'plain'))

    # try:
    with smtplib.SMTP(SMTP_SERVER , SMTP_PORT) as server:
        server.sendmail(SENDER_EMAIL , receiver_mail,  msg.as_string())  # sending the message
        print("email sent successfully")
    # except:
        # print("error sending of mail")

def main():
    data = fetch_data_from_db()
    for i in data:
        job_id = i[0]
        email = 'bikash.maharana@jindalsteel.com'
        mybody = f"""\
            Hello,
            {job_id}
            This is a reminder regarding your document verification.

            Regards,
            Team"""
        send_mail(email ,mybody)



if __name__ == "__main__":
    main()
