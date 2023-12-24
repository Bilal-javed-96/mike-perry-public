//Get aws instance details
data "aws_instance" "source_instance" {
  instance_id = var.source_instance_id
}

resource "aws_ami_from_instance" "sourceami" {
  name               = "source-instance"
  source_instance_id = var.source_instance_id
}

resource "aws_instance" "newinstance" {
  ami           = aws_ami_from_instance.sourceami.id
  instance_type = data.aws_instance.source_instance.instance_type
  vpc_security_group_ids = data.aws_instance.source_instance.vpc_security_group_ids
  subnet_id = data.aws_instance.source_instance.subnet_id
  tags = {
    Name = var.ec2_name
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo mkdir /root/efs
    sudo umount /root/efs
    sudo sed -i '/\/root\/efs/d' /etc/fstab
    sudo mount -t efs -o tls ${var.efs_ip} /root/efs/
    echo "${var.efs_ip}:/   /root/efs   nfs   nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport   0 0" | sudo tee -a /etc/fstab
    sudo mount -a
    sudo mv /opt/tomcat9/webapps/manager/META-INF/context.xml /opt/tomcat9/webapps/manager/META-INF/context.xml-original
    touch context.xml
       cat <<-EOF1 > context.xml
      <Context reloadable="false">
      <Resources
          allowLinking="true"
          cachingAllowed="false" />
      <Resource
          name="jdbc/betok"
          auth="Container"
          type="javax.sql.DataSource"
          maxTotal="150"
          maxWaitMillis="20000"
          minIdle="10"
          maxIdle="150"
          driverClassName="com.mysql.jdbc.Driver"
          username="${var.db_username}"
          password="${var.db_password}"
          url="${var.db_url}"
          minEvictableIdleTimeMillis="180000"
          defaultAutoCommit="true"
          removeAbandonedOnBorrow="true"
          removeAbandonedTimeout="300"
          logAbandoned="true"
          validationQuery="select 1"
          validationQueryTimeout="60"
          testWhileIdle="true"
          testOnBorrow="true"
          />
        </Context>
    EOF1
    sudo cp context.xml /opt/tomcat9/webapps/manager/META-INF/
    sudo chown tomcat:tomcat /opt/tomcat9/webapps/manager/META-INF/context.xml
  EOF 

  depends_on = [ aws_ami_from_instance.sourceami ]
}