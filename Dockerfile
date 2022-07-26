FROM sanjufree/pdf_edit:v2

# for Binder
RUN python3.8 -m pip install --no-cache-dir notebook jupyterlab
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

USER root
WORKDIR /home/${NB_USER}

RUN bash -c "echo -e 'toor\ntoor' | (passwd root)" && bash -c "echo -e 'jovyan\njovyan' | (passwd jovyan)"
COPY hello_pdf_edit.ipynb .
COPY sample.pdf .
RUN chmod +w hello_pdf_edit.ipynb

RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

ENTRYPOINT []