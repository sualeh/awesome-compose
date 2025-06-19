# Orthanc

Orthanc is a lightweight, open-source DICOM server designed to facilitate medical imaging workflows. It includes a web-based DICOM viewer that allows users to visualize and interact with medical images directly through a browser. The viewer supports 2D and 3D rendering, including PET-CT fusion, and is built on top of Orthanc's REST API.

The source code for the Orthanc Viewer is on [GitHub](https://github.com/npettiaux/orthanc-viewer). For broader context and documentation, the [official Orthanc website](https://www.orthanc-server.com/) is also a great resource.


## Why It's Useful

- **Medical imaging workflow**: Streamline DICOM file management and viewing for healthcare professionals
- **Web-based viewer**: Access medical images through any modern browser without additional software
- **Standards compliant**: Full DICOM support with REST API for integration with other systems
- **Free and open-source**: No licensing fees with complete source code availability
- **Self-hosted**: Deploy on your own infrastructure with complete control over sensitive medical data


## Usage

Once you've started the container with Docker Compose, access Orthanc through your browser at: http://localhost:8042

The DICOM server also runs on port 4242 for receiving medical images from DICOM clients. The compose file uses the latest version with plugins for enhanced functionality.


## References

- [Orthanc Official Website](https://www.orthanc-server.com/)
- [Orthanc Viewer GitHub Repository](https://github.com/npettiaux/orthanc-viewer)
- [Orthanc Docker Hub](https://hub.docker.com/r/jodogne/orthanc-plugins)
- [Orthanc Documentation](https://book.orthanc-server.com/)
- [DICOM Standard](https://www.dicomstandard.org/)

