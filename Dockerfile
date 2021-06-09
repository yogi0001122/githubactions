FROM ubuntu:16.04

RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update -y \
    && apt-get install -y python-dev libpq-dev python3.6 curl build-essential python3-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev \
    && apt-get install -y python3-setuptools python3.6-dev

WORKDIR /flaskapp
COPY . /flaskapp

RUN rm -rf /usr/bin/python \
    && ln -s /usr/bin/python3.6 /usr/bin/python \
    && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
    && python get-pip.py \
    && pip --version

RUN pip install -r requirements.txt

CMD python manage.py run
