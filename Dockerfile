FROM oraclelinux:6

# Install supplementary packages:
RUN yum install -y wget \
                   glibc.i686 \
                   libX11.i686 \
                   libXext.i686 \
                   perl \
                   xhost

# Download and install POSE:
RUN wget -c --no-check-certificate \
        https://downloads.sourceforge.net/project/pose/pose/3.5-2/pose-3.5-2.i386.rpm \
        https://downloads.sourceforge.net/project/pose/pose/3.5-2/pose-perl-3.5-2.i386.rpm \
        https://downloads.sourceforge.net/project/pose/pose/3.5-2/pose-3.5-2.src.rpm \
        https://sourceforge.net/projects/pose/files/skins/1.9%20et%20al/pose-skins-1.9-1.noarch.rpm \
        https://sourceforge.net/projects/pose/files/skins/1.9%20et%20al/pose-skins-handspring-3.1H4-1.noarch.rpm && \
    rpm -i *.rpm && \
    rm -fv *.rpm

# Create user:
RUN adduser -m pose && \
    mkdir /home/pose/images

# PalmOS images will be here:
VOLUME /home/pose/images

USER pose
CMD ["/usr/bin/pose"]
HEALTHCHECK --interval=10s --timeout=10s --start-period=10s --retries=2 \
    CMD pgrep pose
