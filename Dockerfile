FROM ubuntu:22.04

# Cài gói cần thiết
RUN apt-get update && apt-get install -y \
    qemu-kvm \
    novnc \
    websockify \
    supervisor \
    wget \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Cài noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# Tạo ổ cứng ảo 40GB cho Windows
RUN qemu-img create -f qcow2 /root/win10.qcow2 40G

# Tải ISO Windows 10 Home EN x64
RUN wget -O /root/win10.iso "https://software-download.microsoft.com/db/Win10_22H2_English_x64.iso"

# Copy script & supervisord config
COPY start.sh /root/start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /root/start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
