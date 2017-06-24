FROM jupyter/base-notebook

ADD requirements.txt .

USER root
RUN apt-get update && apt-get install -y --no-install-recommends vim unzip

RUN pip install --upgrade pip && pip install -r requirements.txt && rm -f requirements.txt

ADD ngrok-stable-linux-amd64.zip .
RUN unzip ngrok-stable-linux-amd64.zip && mv ngrok /usr/local/bin && rm -f ngrok-stable-linux-amd64.zip

ADD Notebook/*.ipynb Notebook/
ADD Notebook/*.pdf Notebook/
ADD jupyter_notebook_config.py /home/jovyan/.jupyter/
RUN chown -R jovyan:users .

USER jovyan

EXPOSE 8888 4040

