FROM python:3.8.10-buster
WORKDIR /content
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata 
RUN apt-get -y update && apt-get -y upgrade && \
apt-get install -y git wget cmake g++ nano vim unzip zip libimage-exiftool-perl

RUN git clone https://github.com/PDFTron/PDFNetWrappers -b 7.1 && \
cd /content/PDFNetWrappers/PDFNetC && \
wget http://www.pdftron.com/downloads/PDFNetC64.tar.gz && \
tar xvzf PDFNetC64.tar.gz && \
mv PDFNetC64/Headers/ . && \
mv PDFNetC64/Lib/ .
RUN cd /content/PDFNetWrappers && \
apt-get install -y libpcre3 libpcre3-dev && \
wget https://liquidtelecom.dl.sourceforge.net/project/swig/swig/swig-4.0.1/swig-4.0.1.tar.gz && \
tar -xzvf swig-4.0.1.tar.gz && \
cd swig-4.0.1 && \
./configure  && \
make && make install #installs swig

#RUN cmake -D BUILD_PDFNetPython=ON .
#RUN make && make install

# COPY ./PDFNW.zip /tmp/PDFNW.zip
COPY ./PDFNW.zip.xaa /tmp/PDFNW.zi.1
COPY ./PDFNW.zip.xab /tmp/PDFNW.zi.2
RUN ( cat /tmp/PDFNW.zi.* > /tmp/PDFNW.zip ) && rm /tmp/PDFNW.zi.* && \
 unzip /tmp/PDFNW.zip -d /colabvm/ && rm -rf /tmp/PDFNW.zip && \
 rm -rf PDFNetWrappers/ && cp -r /colabvm/content/PDFNetWrappers /content/ && \
 rm -rf /colabvm

RUN echo PYTHONPATH="/content/PDFNetWrappers/PDFNetC/Lib" > /content/PDFNetWrappers/.env
# test
RUN python3.8 -c "__import__('site').addsitedir('/content/PDFNetWrappers/PDFNetC/Lib'); from PDFNetPython import PDFNet,PDFDoc,ElementWriter,ElementReader,SDFDoc,Element,ColorSpace,ColorPt"

ENTRYPOINT bash
