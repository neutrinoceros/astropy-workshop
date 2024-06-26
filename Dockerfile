FROM jupyter/minimal-notebook:ubuntu-22.04


ARG NB_USER=jovyan
ARG NB_UID=1000
ARG PYTHON_ENV=astropy-env
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN cd ${HOME} && \
    mamba update conda && \
    conda env create -n $PYTHON_ENV --file 00-Install_and_Setup/environment.yml && \
    conda init bash && \
    conda run -n $PYTHON_ENV pip install -r 00-Install_and_Setup/requirements.txt && \
    printf "\nconda activate $PYTHON_ENV\n" >> ${HOME}/.bashrc
  
ENV PATH /opt/conda/envs/astropy-env/bin:$PATH


