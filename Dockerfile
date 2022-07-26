FROM sanjufree/pdf_edit:v1

# for Binder
RUN python3 -m pip install --no-cache-dir notebook==5.7.4 jupyterlab==0.35.5
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root

RUN bash -c "echo toor | passwd --stdin root" && bash -c "echo jovyan | passwd --stdin jovyan"
COPY hello_pdf_edit.ipynb .
COPY sample.pdf .
RUN chmod +w hello_pdf_edit.ipynb

RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR /home/${NB_USER}
ENTRYPOINT []