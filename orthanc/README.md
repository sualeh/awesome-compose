# Orthanc

Orthanc is a lightweight, open-source DICOM server designed to facilitate medical imaging workflows. It includes a web-based DICOM viewer that allows users to visualize and interact with medical images directly through a browser. The viewer supports 2D and 3D rendering, including PET-CT fusion, and is built on top of Orthanc's REST API.

The source code for the Orthanc Viewer is on [GitHub](https://github.com/npettiaux/orthanc-viewer). For broader context and documentation, the [official Orthanc website](https://www.orthanc-server.com/) is also a great resource.


## Usage

Once you've started the container with Docker Compose, access Orthanc through your browser at: http://localhost:8042

Then click on "Open Orthanc Explorer 2" to launch the web-based DICOM viewer. Upload the folder containting the DICOM files you want to view, and the viewer will render the images for you.

The DICOM server also runs on port 4242 for receiving medical images from DICOM clients. The compose file uses the latest version with plugins for enhanced functionality.


## References

- [Orthanc Official Website](https://www.orthanc-server.com/)
- [Orthanc Viewer GitHub Repository](https://github.com/npettiaux/orthanc-viewer)
- [Orthanc Docker Hub](https://hub.docker.com/r/jodogne/orthanc-plugins)
- [Orthanc Documentation](https://book.orthanc-server.com/)
- [DICOM Standard](https://www.dicomstandard.org/)

